Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVADWpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVADWpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVADWoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:44:05 -0500
Received: from host-16.subnet-17.med.umich.edu ([141.214.17.16]:20384 "HELO
	webshield-01.med.umich.edu") by vger.kernel.org with SMTP
	id S262405AbVADWlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:41:50 -0500
Message-Id: <s1dad55b.011@med-gwia-02a.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 
Date: Tue, 04 Jan 2005 17:41:34 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <grendel@caudium.net>, <willy@w.ods.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Very high load on P4 machines with 2.4.28
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Willy Tarreau <willy@w.ods.org> 01/04/05 5:05 PM >>>
>> Oh, while I'm at it, are you using hyperthreading, and if so, could
you
>> disable it ? I have seen many cases where it degrades performances
>> significantly (eg: highly loaded user space network applications).

>Willy

Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM
hyperthreading) if the load doesn't warrant it.

(Now how about that for Linux?) :)

Nik

On Tue, Jan 04, 2005 at 08:56:36PM +0100, Marek Habersack wrote:
> Hello,
> 
>  We have several machines with similar configurations
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub
(rev 02)
> 0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP
Controller (rev 02)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC
Bridge (rev 02)
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150
Storage Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
> 0000:02:09.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
> 0000:02:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)
> 0000:02:0b.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)
> 
> and
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE
DRAM Controller/Host-Hub Interface (rev 03)
> 0000:00:02.0 VGA compatible controller: Intel Corp.
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC
Bridge (rev 02)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L)
UltraATA-100 IDE Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 02)
> 0000:01:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
> 0000:01:06.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
> 
> equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel
config
> is attached. The machines have normal load averages hovering not
higher than
> 7.0, depending on the time of the day etc. Two of the machines run
2.4.25,
> one 2.4.27 and they work fine. When booted with 2.4.28, though
(compiled
> with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config),
the load
> is climbing very fast and hovers around a value 3-4 times higher than
with
> the older kernels. Booted back in the old kernel, the load comes to
its
> usual level. The logs suggest nothing, no errors, nothing unusual is
> happening. 
> 
> Has anyone had similar problems with 2.4.28 in an environment
resembling the
> above? Could it be a problem with highmem i/o?
> 
> tia,
> 
> marek



**********************************************************
Electronic Mail is not secure, may not be read every day, and should not be used for urgent or sensitive issues.
