Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUEEGgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUEEGgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUEEGgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:36:48 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:35974 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S263089AbUEEGgq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:36:46 -0400
Date: Wed, 05 May 2004 08:36:44 +0200 (CEST)
Message-Id: <20040505.083644.241899480.rene@rocklinux-consulting.de>
To: rmrmg@wp.pl
Cc: m.c.p@kernel.linux-systeme.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <20040504220325.25516d8f.rmrmg@wp.pl>
References: <20040504211939.79ed1e6f.rmrmg@wp.pl>
	<200405042146.40404@WOLK>
	<20040504220325.25516d8f.rmrmg@wp.pl>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Tue, 4 May 2004 22:03:25 +0200,  =?ISO-8859-1?Q?=20Rafa=B3?= 'rmrmg'
	Roszak <rmrmg@wp.pl> wrote: > begin Marc-Christian Petersen
	<m.c.p@kernel.linux-systeme.com> quote: > > > On Tuesday 04 May 2004
	21:19,  =?ISO-8859-1?Q?=20Rafa=B3?= 'rmrmg' Roszak wrote: > > > > Hi  =?ISO-8859-1?Q?=20Rafa=B3?= > > > > > make[2]:
	Entering directory `/usr/src/linux-2.4.27-pre2/kernel' > > > gcc
	-D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall > > >
	-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing > > >
	-fno-common-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 > >
	> -march=athlon-nostdinc -iwithprefix include -DKBUILD_BASENAME=sched >
	> > -fno-omit-frame-pointer -c -o sched.o sched.c sched.c:213: error: >
	> > conflicting types for 'reschedule_idle' sched.c:210: error:
	previous > > > declaration of 'reschedule_idle' was here sched.c:213:
	error: > > > conflicting types for 'reschedule_idle' sched.c:210:
	error: previous > > > declaration of 'reschedule_idle' was here
	sched.c:371: error: > > > This problem exist when i use GCC-3.4.0,
	GCC-3.2.3 doesn't cause it. > > > > Does the attached patch help there?
	[...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Tue, 4 May 2004 22:03:25 +0200,
    Rafa³ 'rmrmg' Roszak <rmrmg@wp.pl> wrote:
> begin  Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com> quote:
> 
> > On Tuesday 04 May 2004 21:19, Rafa³ 'rmrmg' Roszak wrote:
> > 
> > Hi Rafa³
> > 
> > > make[2]: Entering directory `/usr/src/linux-2.4.27-pre2/kernel'
> > > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall
> > > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > > -fno-common-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
> > > -march=athlon-nostdinc -iwithprefix include -DKBUILD_BASENAME=sched
> > > -fno-omit-frame-pointer -c -o sched.o sched.c sched.c:213: error:
> > > conflicting types for 'reschedule_idle' sched.c:210: error: previous
> > > declaration of 'reschedule_idle' was here sched.c:213: error:
> > > conflicting types for 'reschedule_idle' sched.c:210: error: previous
> > > declaration of 'reschedule_idle' was here sched.c:371: error:
> > > This problem exist when i use GCC-3.4.0, GCC-3.2.3 doesn't cause it.
> > 
> > Does the attached patch help there?

This patch should build a gcc-3.4 kernel with nearly everything
enabled on x86 and PowerPC (maybe more):

http://dl.rocklinux-consulting.de/oss/linux24/gcc340-fixes-v2.4.26-try3.patch

It is for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I
have not yet booted the resulting kernel, soo ....

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

