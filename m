Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUBTQ71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUBTQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:59:27 -0500
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:33521 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S261340AbUBTQ7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:59:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Still have build error on 2.6.2 fc/proc/array.c
Date: Fri, 20 Feb 2004 09:59:07 -0700
Message-ID: <0A78D025ACD7C24F84BD52449D8505A15A80DD@wcosmb01.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Still have build error on 2.6.2 fc/proc/array.c
Thread-Index: AcP3sgtZlWklGICiSh6HE3K2Xohf4AAH4vUw
From: <yiding_wang@agilent.com>
To: <marco.roeland@xs4all.nl>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Feb 2004 16:59:08.0679 (UTC) FILETIME=[DB0D7170:01C3F7D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco,

I got things straighten up by changing the code array.c, followed your example on web.  I also downloaded gcc 3.3.3 but dare to try it now. The gcc 2.96 bug should be described in 2.6.2 Changes file which only mentioned the gcc 2.95 and beyond will be OK,

Thanks!

Eddie

> -----Original Message-----
> From: Marco Roeland 
> [mailto:marco@localhost.cos.agilent.com]On Behalf Of
> Marco Roeland
> Sent: Friday, February 20, 2004 5:03 AM
> To: WANG,YIDING (A-SanJose,ex1)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Still have build error on 2.6.2 fc/proc/array.c
> 
> 
> On Tuesday February 17th yiding_wang@agilent.com wrote:
> 
> > Based on README and requirement of Changes in linux-2.6.2, 
> I have updated needed utilities and other files with the following:
> > binnutils 2.14
> > e2fsprogs-1.34
> > module-init-tools-3.0-pre10
> > procps 3.1.15
> > 
> > Everything is installed OK.
> > 
> > Then compiling new 2.6.2 kernel still fails wi the 
> following.  What is the upgrade file for this problem?
> 
> Your kernel sources and all the mentioned tools are now OK, 
> and probably
> were OK already. The only thing that is giving you the error is the
> version of the gcc compiler that you use (2.96).
> 
> > make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >   CHK     include/linux/compile.h
> >   CC      fs/proc/array.o
> > fs/proc/array.c: In function `proc_pid_stat':
> > fs/proc/array.c:398: Unrecognizable insn:
> > (insn/i 727 1015 1009 (parallel[ 
> > ...
> 
> It is the *compiler* (gcc-2.96) that has a bug here. As this 
> version of
> gcc has many other bugs developers no longer work around difficulties
> this specific version of gcc has.
> 
> What you can do is upgrade your gcc package to a later 
> version (3.2.x or
> 3.3.x or even later from your distribution). As a workaround 
> I've made a
> little patch that you can apply to fs/proc/array.c if you 
> still want to
> keep using gcc 2.96 for a little while. It's archived here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107567013416122&w=2
> -- 
> Marco Roeland
> 
