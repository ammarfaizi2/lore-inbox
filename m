Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWDUTah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWDUTah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWDUTag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:30:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbWDUTaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:30:35 -0400
Date: Fri, 21 Apr 2006 12:28:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de,
       smartmontools-support@lists.sourceforge.net
Subject: Re: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
In-Reply-To: <44493023.4010109@pobox.com>
Message-ID: <Pine.LNX.4.64.0604211226120.3701@g5.osdl.org>
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
 <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.0604211511120.22768@p34>
 <44493023.4010109@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Apr 2006, Jeff Garzik wrote:
> 
> You can force the disk to replace the bad sectors by doing a disk-level write:
> 
> 	dd if=/dev/zero of=/dev/sda1 bs=4k

NOTE! Obviously don't do this before you've backed up the disk.  Depending 
on the filesystem, you might just have overwritten something important, or 
just your pr0n collection ;)

Jeff, please be a little more careful about telling people commands like 
that. Some people might cut-and-paste the command without realizing what 
it's doing as a way to "fix" their problem.

			Linus
