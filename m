Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292979AbSCIXep>; Sat, 9 Mar 2002 18:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292981AbSCIXeg>; Sat, 9 Mar 2002 18:34:36 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30970
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292979AbSCIXe1>; Sat, 9 Mar 2002 18:34:27 -0500
Date: Sat, 9 Mar 2002 15:35:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020309233503.GE896@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020308022751.GF28141@matchmail.com> <E16jKJX-00069s-00@the-village.bc.nu> <20020308192643.GA29073@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308192643.GA29073@matchmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 11:26:43AM -0800, Mike Fedyk wrote:
> I'll test without preempt and see if it shows up again.  It took a day
> before though, so...
> 

I've been running without preempt for about 28hrs with a make -j5 compile
loop of a kernel tree running, and it looks like it'll do the same thing
again.

Maybe it's from all of the forks as the only things that have been in use are:

mutt (left running, so scanning for new messages in several folders)
exim (receiving message for lkml, debian-(devel|user), etc
top
make -j loop

Mozilla is running, but I haven't been using it...

I'll change to single user mode in monday to check to see if the problem is
reproducable on non-preempt.

The only thing left would be the kernel or glibc (as init still keeps it
open so 'shutdown now' wouldn't free that).

How could I test to kill everything opening glibc and still be able to run a
command to read /proc/meminfo afterward?

Mike
