Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVHZLlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVHZLlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHZLlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:41:35 -0400
Received: from mum-pop3-c1.vsnl.net ([203.200.235.137]:58311 "EHLO
	mum-pop3-c1.vsnl.net") by vger.kernel.org with ESMTP
	id S964991AbVHZLlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:41:35 -0400
Date: Fri, 26 Aug 2005 16:37:09 +0500
From: vadirajcs@eth.net
Subject: Re: Building the kernel with Cygwin
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Chris du Quesnay <duquesnay@hotmail.com>, linux-kernel@vger.kernel.org
Message-id: <ab3079ab5860.ab5860ab3079@vsnl.net>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.16 (built May 14 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Date: Thursday, August 25, 2005 9:12 pm
Subject: Re: Building the kernel with Cygwin

> 
> On Thu, 25 Aug 2005, Chris du Quesnay wrote:
> 
> > Hi.  I am newbie at GNU/linux.
> >
> > I am trying to build a kernel (2.6.12)  for a powerpc target 
> using cygwin on
> > my i686 machine.  I have
> > Windows 2000 as my operating system.
> >
> > I have recent versions of cygwin (with GNU make 3.80), binutils 
> for the
> > powerpc (gcc v 3.3.1, ld v 2.14)
> >
> > I set
> > ARCH=ppc
> > CROSS_COMPILE= powerpc-ibm-eabi-
> >
> > and I add the cross compiler/build directory to my path.
> >
> > After untaring the kernel, I issue the
> > make mrproper, which appears to work.
> >
> > Then I issue
> > make menuconfig
> >
> > and I get the following error, which I can't seem to get around:
> >
> > HOSTCC   scripts/basic/fixdep
> > fixdep: no such file or directory
> > make[1]:*** [scripts/basic/fixdep] Error 2
> > make[1] Leaving directory /cygdrive/c/Linux_amcc/linux-2.6.12
> >
> >
> > Can you suggest what the problem might be?  Should I be able to 
> build the
> > kernel
> > with cygwin?

  I'm not sure if this is the issue. Usually the cross compilers on MS windows
expects windows file path "c:\" where as the cygwin makefile uses unix path "/".

You can verify that with verbose output of the commmand line of your cross 
compiler to see what path is been used to fetch the file fixdep. 

You could try giving windows absolute path. 



> >
> 
> Try this temporary work-around:
> 
> cd /cygdrive/c/Linux_amcc/linux-2.6.12/scripts/basic
> gcc -O2 -o fixdep fixdep.c
> 
> You may also have to do the same thing for docproc, i.e.,
> gcc -O2 -o docproc docproc.c
> 
> Others may tell you what's wrong, but at least this should get
> you started.



Regards,
Vadiraj



