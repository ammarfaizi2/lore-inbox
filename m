Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTFGTGf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTFGTGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:06:34 -0400
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:62444
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id S263428AbTFGTGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:06:33 -0400
Date: Sat, 7 Jun 2003 15:20:08 -0400
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: lost interrupts with 2.4.1-rc6 and i875p chipset
Message-ID: <20030607192008.GA3345@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
References: <20030603111519.GA23228@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603151809.GA23419@jhereg.dmeyer.net>
User-Agent: Mutt/1.4.1i
X-Newsgroups: local.linux.kernel
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030603151809.GA23419@jhereg.dmeyer.net> you write:
> I see the same thing with my machine:
> 
> $ /sbin/lspci
> 00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
> Bridge (rev 03)
> 00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G]
> Chipset Integrated Graphics Device (rev 03)
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
> 00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
> 00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
> 01:04.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
> 01:09.0 Ethernet controller: Broadcom Corporation: Unknown device 4401 (rev 01)
> 
> though for me it's more likely to be hitting inn really hard than the
> cdrom drive.  Booting with "noapic" fixes it, though obviously at the
> cost of losing whatever advantages the APIC provides.

Followup to this:  with 2.4.21-rc7-ac1, I get very different
behavior.  If I boot with noapic, my machine goes into an endless loop
of

   APIC error on CPU0: 40(40)

errors.  If I boot regularly (APIC enabled), everything is fine.  My
machine has been up for almost a full day without a single lost
interrupt message.  This, BTW, is with ACPI enabled in both cases.

-- 
Dave Meyer
dmeyer@dmeyer.net
