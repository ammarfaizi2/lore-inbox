Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUHVJJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUHVJJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUHVJJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:09:24 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:57028 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266580AbUHVJJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:09:21 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 - intermittent unblanking problem on Radeon Mobility 7500
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Aug 2004 19:09:12 +1000
Message-ID: <2306.1093165752@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an intermittent unblanking problem with a Compaq Evo N800v
laptop, running 2.6.8.1 with xorg x11 6.7.0-2 (Fedora Core 2).  This
occurs from just blanking the screen, I am not shutting the lid.

The screen and backlight correctly turn off after a few minutes.  Most
of the time pressing any key will bring the display back.  On rare
occasions, the backlight comes on but there is no data displayed, just
a blank screen.  Switching back to a text console makes no difference,
nothing is displayed.  Shutting down X and restarting it makes no
difference.  Once the display is gone, the only fix is to reboot the
laptop.

What diagnostics are worth getting for this intermittent problem?  Any
useful card registers that can be dumped?

lspci -v

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 66, IRQ 11
        Memory at 88000000 (32-bit, prefetchable)
        I/O ports at 3000 [size=256]
        Memory at 80380000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

.config extract. ACPI but no APM.  radeon and agpgart modules are
loaded but have a use count of 0.

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
CONFIG_DRM=y
CONFIG_DRM_RADEON=m

