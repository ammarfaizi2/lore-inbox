Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUHaTJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUHaTJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUHaTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:09:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56749 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268851AbUHaTJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:09:04 -0400
Date: Tue, 31 Aug 2004 12:08:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_ACPI totally broken (2.6.9-rc1-mm2)
Message-ID: <231570000.1093979338@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, not only does it not compile in -mm2, you also can't disable it.

Moreover, if you try you get this:

scripts/kconfig/mconf arch/i386/Kconfig
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K7_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K8_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_SPEEDSTEP_CENTRINO_ACPI
Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830

larry:~/linux/2.6.9-rc1-mm2# egrep '(HT|MMCONFIG|HPET)' .config
# CONFIG_HPET_TIMER is not set
# CONFIG_X86_HT is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_HPET is not set

larry:~/linux/2.6.9-rc1-mm2# grep ACPI .config
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_PCI=y

How the hell do you turn this stuff off?

M.

