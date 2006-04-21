Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWDUTO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWDUTO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDUTO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:14:57 -0400
Received: from lucidpixels.com ([66.45.37.187]:54720 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750807AbWDUTO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:14:56 -0400
Date: Fri, 21 Apr 2006 15:14:41 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jeff Garzik <jgarzik@pobox.com>
cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>,
       smartmontools-support@lists.sourceforge.net
Subject: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
In-Reply-To: <440B76B4.5080502@pobox.com>
Message-ID: <Pine.LNX.4.64.0604211511120.22768@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
 <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
 <440B76B4.5080502@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet a new problem, under 2.6.16, when I fill up the disk, smartmontools 
reports this:

Apr 21 14:24:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
(pending) sectors
Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
(pending) sectors
Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Offline uncorrectable
sectors

What made it error under 2.6.16?

$ time dd if=/dev/zero of=file.out
dd: writing to `file.out': No space left on device
781118873+0 records in
781118872+0 records out
399932862464 bytes (400 GB) copied, 8873.06 seconds, 45.1 MB/s

real    147m53.092s
user    8m1.395s
sys     42m4.500s

$

Under 2.6.15.x, I did not see this behavior, is this going bad, or?

Thanks,

Justin.

