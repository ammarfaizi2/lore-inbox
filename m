Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266689AbSKHAtK>; Thu, 7 Nov 2002 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266694AbSKHAtK>; Thu, 7 Nov 2002 19:49:10 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39396 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266689AbSKHAtJ>;
	Thu, 7 Nov 2002 19:49:09 -0500
Date: Thu, 7 Nov 2002 16:55:47 -0800
To: rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108005547.GB837@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021107224750.GA699@bougret.hpl.hp.com> <20021108001822.E11437@flint.arm.linux.org.uk> <20021108004155.GA837@bougret.hpl.hp.com> <20021108004924.H11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108004924.H11437@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:49:24AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 04:41:55PM -0800, Jean Tourrilhes wrote:
> > 	Is there a way to see the current flag configuration of the
> > port with setserial or /proc ?
> 
> stty -a -F /dev/ttySx
> 
> should do the trick.

	2.5.X :
-----------------------------------
speed 9600 baud; rows 0; columns 0; line = 11;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal -crtscts
ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff
-iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0
ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop
-echoprt -echoctl -echoke
-----------------------------------

	2.4.X :
-------------------------
speed 9600 baud; rows 0; columns 0; line = 11;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal -crtscts
ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff
-iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0
ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop
-echoprt -echoctl -echoke
-------------------------

	I'll try to dig further. It might be the hardware...

	Jean
