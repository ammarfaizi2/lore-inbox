Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSJ0Rjw>; Sun, 27 Oct 2002 12:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJ0Rjw>; Sun, 27 Oct 2002 12:39:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15777 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261331AbSJ0Rjv>; Sun, 27 Oct 2002 12:39:51 -0500
Message-Id: <5.1.1.6.0.20021027093253.020d5ed8@pop.aracnet.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 27 Oct 2002 09:46:03 -0800
To: linux-kernel@vger.kernel.org
From: Arthur Aldridge <aj@yasashi.net>
Subject: RE: Problem with ACPI on Abit KT7,HPT370 (Work Around)
Cc: dominik@geisel.info, dominik@unix-ag.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Well after posting I continued to play around and found working
combinations.

   It certainly seems to be an ACPI issue. BIOS defaults in the
PNP/PCI Config screen are PNP OS = No, and all the PIRQ_#s
are set to auto. With my setup that yields IDE = IRQ 14, USBs
and Net = 10, Sound = 11, VGA = 9, HPT370 = 11 and ACPI = 11.
If I explicitly set any of the IRQ in a manner in which the HPT370
doesn't end up sharing IRQ with the ACPI controller the system
boots. The easiest way is to only explicitly set the HPT370 to IRQ
10. I don't know much about ACPI and don't know what the
significance of sharing the ACPI controller's IRQ is but this doesn't
seem to be an IRQ sharing issue as even with IDE =14, ACPI =11,
and every other PCI device sharing IRQ 10 the kernel comes up
with out issue. Also setting PNP OS either way doesn't seem to
relevant.


 >Dominik Geisel (dominik_at_geisel.info) Wrote:
 >
 >I tried 2.4.10-ac10 with your config and played around with all possible
 >BIOS settings...the problem persists.
 >Also, I am now quite sure it broke with BIOS version 3R.

 >>On Mon, Oct 08, 2001 at 10:35:42PM +0200, Dominik Thinay wrote:
 >> with kernel 2.4.11-pre3-xfs + i2c CVS-patch + lmsensors it works fine 
on my
 >> system (Abit Bios KT7_49B0)
 >> CONFIG_PM=y
 >> CONFIG_ACPI=y
 >> CONFIG_ACPI_DEBUG=y
 >> CONFIG_ACPI_BUSMGR=y
 >> CONFIG_ACPI_SYS=y
 >> CONFIG_ACPI_CPU=y
 >> CONFIG_ACPI_BUTTON=y
 >>
 >> I remember disabled sth in the bios ...but i have forget ... :(




--
Arthur Aldridge
Sun Certified Solaris Admin
aj@yasashi.net

