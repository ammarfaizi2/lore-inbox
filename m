Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHRJJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHRJJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 05:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUHRJJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 05:09:49 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:44501
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265230AbUHRJJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 05:09:47 -0400
Message-ID: <41231CD8.5020300@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 11:09:44 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Andreas Messer <andreas.messer@gmx.de>, linux-kernel@vger.kernel.org,
       Ballarin.Marc@gmx.de, christer@weinigel.se
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home> <41231790.7060806@bio.ifi.lmu.de>
In-Reply-To: <41231790.7060806@bio.ifi.lmu.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I missed one case: When calling cdrecord with no cd in the plextor
for the first time after booting, i.e., when /etc/hotplug/block.agent
(on SuSE 9.1) jumps in, I see a 0x1 additionally:

Aug 18 10:27:00 zassenhaus /etc/hotplug/block.agent[8396]: new block device /block/hdc
Aug 18 10:27:00 zassenhaus /etc/hotplug/block.agent[8397]: new block device /block/hdd
Aug 18 10:27:56 zassenhaus kernel: SCSI-CMD Filter: 0x1e not allowed with read-mode
Aug 18 10:28:01 zassenhaus kernel: SCSI-CMD Filter: 0x1 not allowed with read-mode
Aug 18 10:28:02 zassenhaus kernel: SCSI-CMD Filter: 0x1e not allowed with read-mode
Aug 18 10:28:02 zassenhaus kernel: SCSI-CMD Filter: 0xe9 not allowed with read-mode
...

The 0x1 does not appear afterwors anymore...

Does it, by the way, make any sense that I report this here? Or will the
security model have to be desgined first like you discussed it, before
such tests are helpful? Just to avoid that I flood you with a list of
blocked commands when you can't make any use of it now :-)

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

