Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbRLWXaS>; Sun, 23 Dec 2001 18:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284239AbRLWXaJ>; Sun, 23 Dec 2001 18:30:09 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:17668 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S284220AbRLWX35>;
	Sun, 23 Dec 2001 18:29:57 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex" <alex@packetstorm.nu>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6 with dual 1 Gig CPUs and an ICP GDT RAID card
Date: Mon, 24 Dec 2001 00:29:49 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODIEFJCDAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <OE21JxEyBjB7mRBmcso000060dd@hotmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 i had the same problem, unfortunaly i have not been able to debug it yet.
The problem is on my machine it takes a lot longer to lockup. And i dont
have
the machine local at this time. I tried doing it on a Dual Celeron 450 which
i
do have local, but here i can not get it to lockup.

Maybe u should try debugging (kdb and maybe sysrq?) on a serial console, i
dont
know if u already tried that tho.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of T. A.
> Sent: Friday, December 21, 2001 2:26 AM
> To: Keith Owens
> Cc: Linux Kernel Mailing List
> Subject: Re: Consistant complete deadlock with kernel 2.4.16 on an Abit
> VP6 with dual 1 Gig CPUs and an ICP GDT RAID card
>
>
>     Did the two debugging steps listed below.  Tried the
> nmi_watchdog=1 and
> also the kdb debugger.  Unfortunately neither debugging feature
> gave me any
> results.  When the machine locks up the result is total.  The nmi_watchdog
> does not produce any output (after the lockup) and the kdb
> debugger fails to
> load up when pressing the pause key (after the lockup).  I suppose this is
> indicating a hardware issue.  However as I said before my burning
> test under
> FreeBSD was successful.  No machine lockup.  And the last test (under
> FreeBSD) burned in for two days.  I also tried removing a processor.  Just
> as with the non-smp kernel, the lockup did not occur.  Tried single
> processor mode with each processor, both were successful.  Also gave
> 2.2.17-rc2 a try, just in case.  Same result.  As it stands looks like I'm
> still in the same boat.  8-(  Anything else I can do to debug this issue?
>
>     By the way.  Are people:  Successfully using the Abit VP6 motherboard
> under Linux?  Successfully using the ICP GDT7528RN raid controller under
> Linux in an SMP system?  Successfully using an ICP GDT7528RN on a Abit VP6
> motherboard?
>
> ----- Original Message -----
> From: "Keith Owens" <kaos@ocs.com.au>
> To: "T. A." <tkhoadfdsaf@hotmail.com>
> Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> Sent: Thursday, December 20, 2001 9:10 AM
> Subject: Re: Consistant complete deadlock with kernel 2.4.16 on
> an Abit VP6
> with dual 1 Gig CPUs and an ICP GDT RAID card
>
>
> > On Wed, 19 Dec 2001 16:22:47 -0500,
> > "T. A." <tkhoadfdsaf@hotmail.com> wrote:
> > >    Anyone know how I could debug the cause of this problem?  Machine
> > >deadlocks.  Not even an Ooops so I'm short on ideas on how to track the
> > >problem down.  Please help.  8-(  My new SMP system sucks on
> Linux.  8-(
> >
> > Compile for SMP and boot with nmi_watchdog=1.  If the problem is
> > hardware that will not help.  If the problem is a software loop in
> > kernel space (much more likely) then the nmi watchdog will trip after 5
> > seconds.
> >
> > You might also find the kernel debugger to be useful,
> > ftp://oss.sgi.com/projects/kdb/download/ix86.  See Documentation/kdb
> > for man pages.  Using the pause key on a PC keyboard or control-A on a
> > serial console will drop into kdb, unless the kernel has stopped
> > processing interuupts, in which case the nmi watchdog should trip and
> > drop you into kdb.
> >
> > For all low level debugging, I strongly recommend a serial console so
> > you can capture the output on another system, see
> > Documentation/serial-console.txt.
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



