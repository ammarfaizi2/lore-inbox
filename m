Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUHQGcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUHQGcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHQGcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:32:46 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:41397
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263795AbUHQGco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:32:44 -0400
Message-ID: <4121A689.8030708@bio.ifi.lmu.de>
Date: Tue, 17 Aug 2004 08:32:41 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jwendel10@comcast.net,
       linux-kernel@vger.kernel.org, Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net>	<20040816143817.0de30197.Ballarin.Marc@gmx.de>	<1092661385.20528.25.camel@localhost.localdomain> <20040816231211.76360eaa.Ballarin.Marc@gmx.de>
In-Reply-To: <20040816231211.76360eaa.Ballarin.Marc@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin wrote:
> List of SCSI commands in cdrecord and k3b. Completeness and corectness are
> not guaranteed and not even likely. Not all commands are actually used,
> some are only for older hardware.
> 
> MODE_SELECT_* is not needed by cdrecord and fails gracefully as Kai
> Makisara suspected. k3b seems broken, as it doesn't recognize devices as
> writers if MODE_SELECT_10 fails (even when opening the device read-only).
> 
> Commands prepended by "->" are (probably) not mentioned in kernel include
> files.
> 
> Now all that is left to do is determining which commands are safe and
> fixing apps that only open devices read-only ;-)

So what's the target in this process? Should users finally be able to
write cds again without or only with suid bit set? It would be good to
know if I should try to set all cd writing applications suid or just
have to wait for some patches coming up that would allow users to
write cds without suid again...

If the programs must be set suid, is that safe? In the past I was
always told that setting e.g. cdrecord suid was a possible security issue.
But I really don't understand enough of the new security model in the
kernel to judge if that's right or wrong...

Can someone enlighten me? :-)

cu,
Frank
-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

