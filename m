Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUHTMqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUHTMqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUHTMqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:46:23 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:60833
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266643AbUHTMpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:45:46 -0400
Message-ID: <4125F278.50105@bio.ifi.lmu.de>
Date: Fri, 20 Aug 2004 14:45:44 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>	 <4124BA10.6060602@bio.ifi.lmu.de>	 <1092925942.28353.5.camel@localhost.localdomain>	 <4125AC3B.8060707@bio.ifi.lmu.de> <1093001024.30854.20.camel@localhost.localdomain>
In-Reply-To: <1093001024.30854.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> If you've re-enabled unlimited access to your box you've
> let your users destroy your machine. Whether that matters probably
> depends on your users.

Not unlimited! I just collected all commands that were blocked from
cdrecord and growisofs. Actually, quite a lot :-/ But I'm far from
being expert enough to judge if those commands are safe or not.

Just for the records and if someone is interested it:
In addition to the patch Andreas Messer sent a while I ago, those
commands had to be set safe_for_read on SusE 9.1 with a Nec ND-1300A
and a Plextor PlexWriter W5224TA:

+               safe_for_read(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
+               safe_for_read(REZERO_UNIT),
+               safe_for_read(0xe9),		/* drive specific, unknown */
+               safe_for_read(0xed),		/* drive specific, unknown */
+               safe_for_read(GPCMD_MODE_SELECT_10),
+               safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),
+               safe_for_read(GPCMD_FLUSH_CACHE),
+               safe_for_read(GPCMD_SEND_OPC),
+               safe_for_read(GPCMD_BLANK),
+               safe_for_read(GPCMD_WRITE_10),
+               safe_for_read(GPCMD_FORMAT_UNIT),
+               safe_for_read(GPCMD_SEND_CUE),
+               safe_for_read(0xf5),		/* drive specific, unknown */
+               safe_for_read(GPCMD_READ_BUFFER_CAPACITY),
+               safe_for_read(GPCMD_CLOSE_TRACK),



-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

