Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTKEOms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 09:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKEOmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 09:42:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:33669 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262958AbTKEOmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 09:42:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16297.3166.937468.9288@alkaid.it.uu.se>
Date: Wed, 5 Nov 2003 15:42:38 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Klaus Umbach <Klaus.Umbach@doppelhertz.homelinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi and SMP does not work together.
In-Reply-To: <20031104234828.GA1641@DualPrinzip>
References: <20031104234828.GA1641@DualPrinzip>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Umbach writes:
 > Hello Support Center :-)
 > 
 > Since I have 2 CPUs on my mainboard and compiled the SMP-support in, I
 > cannot use ide-scsi anymore. I guess it must have something to do with
 > apic, because when I use "Local APIC support on uniprocessors", I have
 > the same problem. With no SMP and no local APIC everything works fine.
 > (except the second CPU, of course). Normal ide-cdrom support works, but
 > recording CDs over atapi is not really what I want at the moment.
 > 
 > Mainboard: MSI 694D pro
 > 
 > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)

SMP by default uses the I/O-APIC, and may (depending on kernel version
and .config) also use ACPI, which in turn may trigger ACPI-controlled
PCI IRQ routing.

Try "acpi=off", "pci=noacpi" (or however that don't-use-ACPI-for-PCI
option is spelled), and "noapic" (don't use I/O-APIC).

/Mikael
