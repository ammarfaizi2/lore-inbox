Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287555AbRLaQPH>; Mon, 31 Dec 2001 11:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287556AbRLaQO5>; Mon, 31 Dec 2001 11:14:57 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:33752 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S287555AbRLaQOh>; Mon, 31 Dec 2001 11:14:37 -0500
Date: Mon, 31 Dec 2001 16:14:25 GMT
From: ncw@axis.demon.co.uk
Message-Id: <200112311614.fBVGEPu12551@irishsea.home.craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fully preemptible kernel
In-Reply-To: <20011231132901.GA270@elfie.cavy.de>
In-Reply-To: <1007930466.11789.2.camel@phantasy> <1009396922.1678.9.camel@voyager.rueb.com> <20011231132901.GA270@elfie.cavy.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, Heinz Diehl <hd@cavy.de> wrote:
>  On Wed Dec 26 2001, Steve Bergman wrote:
>  
>  [Preempt-kernel patch for 2.4.17 final]
> > I just compiled 2.4.17 with the patch from your site that looks to be
> > for 2.4.17-final.  Unfortunately, several modules (e.g. unix.o) fail on
> > load with an undefined symbol error (preempt_schedule).
>  
>  No problems here. Are you shure you built the kernel modules and they were
>  installed properly?

It might be because you didn't do a 'make mrproper' on a kernel tree
you've used before for a non-preempt build.  As I understand it the
preempt patch effectively makes your kernel SMP - this changes the
architecture of the kernel so you need a 'make mrproper'.

make mrproper deletes your .config file so save that first if you
wanted it ;-)

Also you need a seperate modules directory - the preempt modules
aren't compatible with non-preempt.  Edit the top level makefile and
put a suffix in.

BTW The preempt patch is working fine here too!
-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
