Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbTHaVrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbTHaVrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:47:11 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:48536 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262697AbTHaVrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:47:04 -0400
Date: Sun, 31 Aug 2003 23:47:01 +0200
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: VIA IO-APIC/ACPI Success - Was: Fixing USB interrupt problems with ACPI enabled [Christian.Guggenberger@physik.uni-regensburg.de]
Message-ID: <20030831234701.D22167@pc9391.uni-regensburg.de>
References: <20030831233812.A22167@pc9391.uni-regensburg.de> <20030831233833.B22167@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030831233833.B22167@pc9391.uni-regensburg.de>; from Christian.Guggenberger@physik.uni-regensburg.de on Sun, Aug 31, 2003 at 23:38:33 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doing this for Len, who is on vacation. We would like to thank the
> people who provided debugging info such as acpidmp, dmidecode, and
> demsg. This is one of our findings, and we believe this would fix some
> interrupt problems (with USB, for example) with ACPI enabled, especially
> when the dmesg reads like:
> 
> ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
> 
> Basically we assumed that _CRS returned the one we set with _SRS, when
> setting up a PCI interrupt link device, but that's not the case with
> some AML codes. Some of them always return 0.
> Attached is a patch against 2.4.23-pre1. It should be easy to apply this
> to 2.6.

Amazing! This patch also fixes IO-APIC problems on my EPOX 8k5a3+ (VIA KT333).
Onboard devices like usb, sound and net (via-rhine) never worked, when the 
mobo operated in APIC mode - now they do, great!
There's also a patch for 2.6 on bugzilla - see Bug #10.
So, if everyone with ACPI/IO-APIC probs with via chipsets would test this one, 
it hopefully would make it into mainstream 2.4 / 2.6  soon.

Thanks!
Christian

P.S. original message:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106225872121774&w=2
