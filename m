Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273244AbTHFCcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273252AbTHFCci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:32:38 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:5030 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP id S273244AbTHFCcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:32:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.5/2.6 NVidia (was Re: 2.4 vs 2.6 ver#
Date: Tue, 5 Aug 2003 22:32:34 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308051041.08078.gene.heskett@verizon.net> <200308051807.00179.gene.heskett@verizon.net> <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
In-Reply-To: <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052232.34823.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [151.205.12.168] at Tue, 5 Aug 2003 21:32:35 -0500
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
>2) './NVIDIA-Linux-x86-1.0-4496-pkg2.run --extract-only'
>3) Go to www.minion.de and get the patch:
> NVIDIA_kernel-1.0-4496-2.5.diff 4) cd
> NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv
>5)  patch -p1 < NVIDIA_kernel-1.0-4496-2.5.diff
>6) cp Makefile.kbuild Makefile
>
>Now *as root*, while running the 2.6 kernel you want support for:
>(either single-user or runlevel 3 (No X) are OK here - reboot if
> needed)
>
>7) cd NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv   if you're not
> there already. 8) make     this will build the nvidia.ko, copy to
> /lib/modules, and insmod it for you. 9) cd ../../..      back to
> the 4496-pgk2 directory
>10) 'make install' to put the /usr/lib parts in place.
>11) Start X in the usual manner - you've probably got an XFconfig
> file with the right NVidia pieces in it already (or you'd not be
> asking ;)
>
>Hope this helps...
>You should be ready to go at that point (note that you will need to
> do (7) and (8) each time you do a 'make modules_install', but 9/10
> only need doing if/when you upgrade from 4496 to a new version.

I just made a script out of that, thanks, now I'm off to reboot and 
try it. :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

