Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTBTRlu>; Thu, 20 Feb 2003 12:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTBTRlu>; Thu, 20 Feb 2003 12:41:50 -0500
Received: from [196.12.44.6] ([196.12.44.6]:26785 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S266298AbTBTRla>;
	Thu, 20 Feb 2003 12:41:30 -0500
Date: Thu, 20 Feb 2003 23:19:56 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Syscall from Kernel Space
In-Reply-To: <20030220174043.GI9800@gtf.org>
Message-ID: <Pine.LNX.4.44.0302202316150.17983-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


but what about masking the process.  An example is... I want to use the
mmap syscall. the kernel implementation uses current->mm, but what i want
to do is, the current macro or the get_current() function should give me
the task_struct of a process so that the effect of the syscall is seen on 
that process and not on the current kernel thread.

Prasad. 

On Thu, 20 Feb 2003, Jeff Garzik wrote:

> On Thu, Feb 20, 2003 at 11:04:37PM +0530, Prasad wrote:
> > 	Is there a way using which i could invoke a syscall in the kernel 
> > space?  The syscall is to be run disguised as another process.  The actual 
> 
> Call sys_<syscall>.  Look at the kernel code for examples.
> 
> Note that typically you don't want to do this... and you _really_ don't
> want to do this if the syscall is not one of the common file I/O
> syscalls (read/write/open/close, etc.)
> 
> 	Jeff

