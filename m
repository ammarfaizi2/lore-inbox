Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSKZVPT>; Tue, 26 Nov 2002 16:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSKZVPT>; Tue, 26 Nov 2002 16:15:19 -0500
Received: from mail.transzap.com ([66.179.36.84]:5091 "HELO connect.oildex.com")
	by vger.kernel.org with SMTP id <S261218AbSKZVPS>;
	Tue, 26 Nov 2002 16:15:18 -0500
Message-ID: <CA3FD75251B0CE43B9B6CA87786E2E4307B386@tzi.transzap.com>
From: Bill Gardner <bgardner@transzap.com>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: aic7xxx driver error at boot for Adaptec AIC-7899P U160
Date: Tue, 26 Nov 2002 14:22:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Justin T. Gibbs [mailto:gibbs@scsiguy.com]
> Sent: Friday, November 22, 2002 16:58
> To: Bill Gardner; 'linux-kernel@vger.kernel.org'
> Subject: Re: aic7xxx driver error at boot for Adaptec AIC-7899P U160
> 
> 
> > Hello!
> > 
> > We are seeing some strange errors at boot time from the 
> aic7xxx driver.
> > 
> > Relevant HW/SW Info:
> > 
> >    Host: Racksaver (Model: RS-1129) with dual AMD 
> Athlon(tm) MP 2100+
> > cpu's    Motherboard: Tyan S2468 with an onboard Adaptec 
> AIC-7899P U160/m
> > (rev 01). 
> >    Dist: Redhat 7.3
> >    Kernel: Linux version 2.4.18-3smp 
> (bhcompile@porky.devel.redhat.com) 
> >       (gcc version 2.96 20000731 (Red Hat Linux 7.3 
> 2.96-110)) #1 SMP Thu
> > Apr 18 06:59:55 EDT 2002
> > 
> > Relevant Console errors:
> > 
> >    scsi0:0:0:0: Attempting to queue an ABORT message
> >    scsi0: Dumping Card State while idle, at SEQADDR 0x44
> > 
> >    ...whole bunch of aic7xxx dump messages (see below for 
> complete list)
> > 
> >    scsi0:0:0:0: Command already completed
> >    aic7xxx_abort returns 0x2002
> 
> Interrupts are not being routed correctly on your system.  There's
> not much the aic7xxx driver can do if interrupts don't work.  One
> of the Linux PCI wizards might be able to help you.
> 
> --
> Justin
> 

Thanks for the pointer...this clued me in to look in other places. The BIOS
on these hosts was broken and luckily there was a later version which fixed
the problem.

For anyone else with the Tyan Thunder K7X (Model S2468): I flashed the
V4.03b BIOS

>From Tyan:

09/30/02 2468403b.exe   TYAN  Thunder K7X (S2468)  V4.03b     Corrects error
message when running non-MP CPU
 
08/16/02 2468v403.exe   TYAN  Thunder K7X (S2468)  V4.03      Add USB boot,
48bit drive size support. ***Fix PCI IRQ routing***, MP table problem. Add
new processor support,  Add new flash part support, work round for ATI
Radeon 7500/78500 card, and work around for NVIDIA chipset Non-PCI
compliance AGP cards.

*** italics mine

..billg
