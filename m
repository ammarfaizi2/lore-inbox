Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKZXx4>; Tue, 26 Nov 2002 18:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSKZXx4>; Tue, 26 Nov 2002 18:53:56 -0500
Received: from imail.ricis.com ([64.244.234.16]:48913 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S261411AbSKZXxx>;
	Tue, 26 Nov 2002 18:53:53 -0500
Date: Tue, 26 Nov 2002 18:01:07 -0600
From: Lee Leahu <lee@ricis.com>
To: Bill Gardner <bgardner@transzap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver error at boot for Adaptec AIC-7899P U160
Message-Id: <20021126180107.7ab9ad44.lee@ricis.com>
In-Reply-To: <CA3FD75251B0CE43B9B6CA87786E2E4307B386@tzi.transzap.com>
References: <CA3FD75251B0CE43B9B6CA87786E2E4307B386@tzi.transzap.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

Just to note,  I am having similar issues using the 2.4.19-64gb-smp kernel optimized for a 586.
oddly enough,  using the default 2.4.19-4gb (non-smp) kernel, it worked just fine.

Also to note, these are the default out-of-the-box kernels from suse.

my system is a dual processor

Tyan Tiger 230T S2507T motherboard
Dual pentium III  1.13 ghz processors
1.5 gb pc-133 sdram.


additional hardware i have:
(from /proc/pci):

  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xef001000 [0xef001fff].

(from /proc/scsi/scsi):

Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W8220T Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02


Bill Gardner <bgardner@transzap.com> scribbled something about RE: aic7xxx driver error at boot for Adaptec AIC-7899P U160:

> 
> 
> > -----Original Message-----
> > From: Justin T. Gibbs [mailto:gibbs@scsiguy.com]
> > Sent: Friday, November 22, 2002 16:58
> > To: Bill Gardner; 'linux-kernel@vger.kernel.org'
> > Subject: Re: aic7xxx driver error at boot for Adaptec AIC-7899P U160
> > 
> > 
> > > Hello!
> > > 
> > > We are seeing some strange errors at boot time from the 
> > aic7xxx driver.
> > > 
> > > Relevant HW/SW Info:
> > > 
> > >    Host: Racksaver (Model: RS-1129) with dual AMD 
> > Athlon(tm) MP 2100+
> > > cpu's    Motherboard: Tyan S2468 with an onboard Adaptec 
> > AIC-7899P U160/m
> > > (rev 01). 
> > >    Dist: Redhat 7.3
> > >    Kernel: Linux version 2.4.18-3smp 
> > (bhcompile@porky.devel.redhat.com) 
> > >       (gcc version 2.96 20000731 (Red Hat Linux 7.3 
> > 2.96-110)) #1 SMP Thu
> > > Apr 18 06:59:55 EDT 2002
> > > 
> > > Relevant Console errors:
> > > 
> > >    scsi0:0:0:0: Attempting to queue an ABORT message
> > >    scsi0: Dumping Card State while idle, at SEQADDR 0x44
> > > 
> > >    ...whole bunch of aic7xxx dump messages (see below for 
> > complete list)
> > > 
> > >    scsi0:0:0:0: Command already completed
> > >    aic7xxx_abort returns 0x2002
> > 
> > Interrupts are not being routed correctly on your system.  There's
> > not much the aic7xxx driver can do if interrupts don't work.  One
> > of the Linux PCI wizards might be able to help you.
> > 
> > --
> > Justin
> > 
> 
> Thanks for the pointer...this clued me in to look in other places. The BIOS
> on these hosts was broken and luckily there was a later version which fixed
> the problem.
> 
> For anyone else with the Tyan Thunder K7X (Model S2468): I flashed the
> V4.03b BIOS
> 
> From Tyan:
> 
> 09/30/02 2468403b.exe   TYAN  Thunder K7X (S2468)  V4.03b     Corrects error
> message when running non-MP CPU
>  
> 08/16/02 2468v403.exe   TYAN  Thunder K7X (S2468)  V4.03      Add USB boot,
> 48bit drive size support. ***Fix PCI IRQ routing***, MP table problem. Add
> new processor support,  Add new flash part support, work round for ATI
> Radeon 7500/78500 card, and work around for NVIDIA chipset Non-PCI
> compliance AGP cards.
> 
> *** italics mine
> 
> ..billg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
