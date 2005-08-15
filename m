Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVHOSaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVHOSaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVHOSaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:30:17 -0400
Received: from mirapoint5.brutele.be ([212.68.199.150]:47630 "EHLO
	mirapoint5.brutele.be") by vger.kernel.org with ESMTP
	id S964895AbVHOSaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:30:15 -0400
Date: Mon, 15 Aug 2005 20:29:48 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815182947.GA6286@localhost.localdomain>
References: <20050815102925.GA843@localhost.localdomain> <20050815110836.GA16201@mipter.zuzino.mipt.ru> <20050815112122.GB6451@localhost.localdomain> <20050815162437.GA10114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050815162437.GA10114@kroah.com>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.9i
X-Junkmail-Status: score=10/50, host=mirapoint5.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090205.4300DCB2.007A-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Monday 15 August 2005 a 09:08, Greg KH ecrivait: 
> On Mon, Aug 15, 2005 at 01:21:22PM +0200, Stephane Wirtel wrote:
> > Le Monday 15 August 2005 a 15:08, Alexey Dobriyan ecrivait: 
> > > On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> > > > With a laptop hard disk adaptop to usb, I do a modprobe with the
> > > > usb-storage module. If I disconnect my hard disk, I get an oops.
> > > 
> > > > nvidia 3711688 14 - Live 0xe10f1000
> > > 
> > > > EIP:    0060:[<c019710b>]    Tainted: P      VLI
> > > 
> > > Is it reproducable without nvidia module loaded?
> > Yes :( 
> 
> Can you do so with 2.6.13-rc6 and without the nvidia module?  If so,
> please let us know.
I try to patch a 2.6.12.4 with the 2.6.13-rc6 prepatch, but I get some
Hunks

Kernel base : 2.6.12.3 from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.4.tar.bz2
Prepatch : 2.6.13-rc6 from http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2

So, here is the commands :
	mkdir ~/kernel && cd ~/kernel
	tar xfj ~/linux-2.6.12.4.tar.bz2
	bunzip patch-2.6.13-rc6.bz2
	cd linux-2.6.12.4
	patch -p1 < ../patch-2.6.13-rc6
	

patching file arch/ia64/kernel/perfmon.c
patching file arch/ia64/kernel/process.c
patching file arch/ia64/kernel/ptrace.c
Hunk #2 succeeded at 972 with fuzz 1 (offset 7 lines).
Hunk #3 FAILED at 1030.
Hunk #4 FAILED at 1265.
Hunk #5 FAILED at 1298.
Hunk #6 FAILED at 1396.
4 out of 6 hunks FAILED -- saving rejects to file
arch/ia64/kernel/ptrace.c.rej
patching file arch/ia64/kernel/setup.c
patching file arch/ia64/kernel/signal.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 

Thanks, 

Stephane Wirtel

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>

