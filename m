Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274863AbTHFC5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274833AbTHFCzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:55:00 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:37255 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S274836AbTHFCx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:53:58 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.5/2.6 NVidia (was Re: 2.4 vs 2.6 ver#
Date: Tue, 5 Aug 2003 22:53:57 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308051041.08078.gene.heskett@verizon.net> <200308051807.00179.gene.heskett@verizon.net> <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
In-Reply-To: <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052253.57257.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.12.168] at Tue, 5 Aug 2003 21:53:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 22:08, Valdis.Kletnieks@vt.edu wrote:
>On Tue, 05 Aug 2003 18:07:00 EDT, you said:
>> Now, the factory nvidia drivers will not build for 2.6, so I don't
>> have any X.  Whats the status of the kernel versions vis-a-vis
>> running a gforce2 MMX 32 megger?
>
>(Sorry for replying to the list, but let's get this into the
> archives in case people actually search before asking... (yeah
> right ;))
>
>I'm running the NVidia 4496 drivers right now on 2.6.0-test2-mm4.
>
>Do the following (can be done on a 2.4 kernel if needed)
>
>1) Get the 4496 drivers from NVidia

check

>2) './NVIDIA-Linux-x86-1.0-4496-pkg2.run --extract-only'

check

>3) Go to www.minion.de and get the patch:
> NVIDIA_kernel-1.0-4496-2.5.diff

check
 
>4) cd NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv

check

>5)  patch -p1 < NVIDIA_kernel-1.0-4496-2.5.diff

check

>6) cp Makefile.kbuild Makefile

check

>Now *as root*, while running the 2.6 kernel you want support for:
>(either single-user or runlevel 3 (No X) are OK here - reboot if
> needed)
>
>7) cd NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv   if you're not
> there already.

check, in the script

> 8) make     this will build the nvidia.ko, copy to
> /lib/modules, and insmod it for you.

check, in the script

> 9) cd ../../..      back to
> the 4496-pgk2 directory

check, in the script

>10) 'make install' to put the /usr/lib parts in place.

check, its rather verbose, even complained about something but I 
didn't capture it :(

>11) Start X in the usual manner - you've probably got an XFconfig
> file with the right NVidia pieces in it already (or you'd not be
> asking ;)

check.  Just one problem, went to black screen about the time the NV 
logo should have popped up, and locked the machine up tight, had to 
use the hardware reset button.

Here is the script:
--------
#!/bin/bash
cd usr/src/nv
make
cd ../../..
make install
--------
which is executed from within that *4496-pkg2 directory

Next time I'll redirect the output of the makes to a scratch file, but 
thats tommorrow now.
>Hope this helps...
>You should be ready to go at that point (note that you will need to
> do (7) and (8) each time you do a 'make modules_install', but 9/10
> only need doing if/when you upgrade from 4496 to a new version.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

