Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRLUR1B>; Fri, 21 Dec 2001 12:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284731AbRLUR0o>; Fri, 21 Dec 2001 12:26:44 -0500
Received: from oe21.law9.hotmail.com ([64.4.8.125]:36112 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S284850AbRLUR0Y>;
	Fri, 21 Dec 2001 12:26:24 -0500
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <24576.1008857426@ocs3.intra.ocs.com.au>
Subject: Re: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6 with dual 1 Gig CPUs and an ICP GDT RAID card
Date: Thu, 20 Dec 2001 20:25:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE21JxEyBjB7mRBmcso000060dd@hotmail.com>
X-OriginalArrivalTime: 21 Dec 2001 17:26:18.0687 (UTC) FILETIME=[99DCACF0:01C18A44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Did the two debugging steps listed below.  Tried the nmi_watchdog=1 and
also the kdb debugger.  Unfortunately neither debugging feature gave me any
results.  When the machine locks up the result is total.  The nmi_watchdog
does not produce any output (after the lockup) and the kdb debugger fails to
load up when pressing the pause key (after the lockup).  I suppose this is
indicating a hardware issue.  However as I said before my burning test under
FreeBSD was successful.  No machine lockup.  And the last test (under
FreeBSD) burned in for two days.  I also tried removing a processor.  Just
as with the non-smp kernel, the lockup did not occur.  Tried single
processor mode with each processor, both were successful.  Also gave
2.2.17-rc2 a try, just in case.  Same result.  As it stands looks like I'm
still in the same boat.  8-(  Anything else I can do to debug this issue?

    By the way.  Are people:  Successfully using the Abit VP6 motherboard
under Linux?  Successfully using the ICP GDT7528RN raid controller under
Linux in an SMP system?  Successfully using an ICP GDT7528RN on a Abit VP6
motherboard?

----- Original Message -----
From: "Keith Owens" <kaos@ocs.com.au>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, December 20, 2001 9:10 AM
Subject: Re: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6
with dual 1 Gig CPUs and an ICP GDT RAID card


> On Wed, 19 Dec 2001 16:22:47 -0500,
> "T. A." <tkhoadfdsaf@hotmail.com> wrote:
> >    Anyone know how I could debug the cause of this problem?  Machine
> >deadlocks.  Not even an Ooops so I'm short on ideas on how to track the
> >problem down.  Please help.  8-(  My new SMP system sucks on Linux.  8-(
>
> Compile for SMP and boot with nmi_watchdog=1.  If the problem is
> hardware that will not help.  If the problem is a software loop in
> kernel space (much more likely) then the nmi watchdog will trip after 5
> seconds.
>
> You might also find the kernel debugger to be useful,
> ftp://oss.sgi.com/projects/kdb/download/ix86.  See Documentation/kdb
> for man pages.  Using the pause key on a PC keyboard or control-A on a
> serial console will drop into kdb, unless the kernel has stopped
> processing interuupts, in which case the nmi watchdog should trip and
> drop you into kdb.
>
> For all low level debugging, I strongly recommend a serial console so
> you can capture the output on another system, see
> Documentation/serial-console.txt.
>
>
