Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286259AbRLTOLB>; Thu, 20 Dec 2001 09:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286260AbRLTOKv>; Thu, 20 Dec 2001 09:10:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:40718 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286259AbRLTOKi>;
	Thu, 20 Dec 2001 09:10:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6 with dual 1 Gig CPUs and an ICP GDT RAID card 
In-Reply-To: Your message of "Wed, 19 Dec 2001 16:22:47 CDT."
             <OE272TUSzbAUfKRfcjc00005359@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Dec 2001 01:10:26 +1100
Message-ID: <24576.1008857426@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001 16:22:47 -0500, 
"T. A." <tkhoadfdsaf@hotmail.com> wrote:
>    Anyone know how I could debug the cause of this problem?  Machine
>deadlocks.  Not even an Ooops so I'm short on ideas on how to track the
>problem down.  Please help.  8-(  My new SMP system sucks on Linux.  8-(

Compile for SMP and boot with nmi_watchdog=1.  If the problem is
hardware that will not help.  If the problem is a software loop in
kernel space (much more likely) then the nmi watchdog will trip after 5
seconds.

You might also find the kernel debugger to be useful,
ftp://oss.sgi.com/projects/kdb/download/ix86.  See Documentation/kdb
for man pages.  Using the pause key on a PC keyboard or control-A on a
serial console will drop into kdb, unless the kernel has stopped
processing interuupts, in which case the nmi watchdog should trip and
drop you into kdb.

For all low level debugging, I strongly recommend a serial console so
you can capture the output on another system, see
Documentation/serial-console.txt.

