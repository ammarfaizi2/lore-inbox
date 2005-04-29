Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVD2Qge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVD2Qge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVD2Qge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:36:34 -0400
Received: from yupa.krose.org ([66.92.73.159]:43248 "EHLO
	chihiro.valley-of-wind.krose.org") by vger.kernel.org with ESMTP
	id S262820AbVD2Qgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:36:31 -0400
Message-ID: <42726287.80104@krose.org>
Date: Fri, 29 Apr 2005 12:36:23 -0400
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI sleep states on Tyan Thunder K8W S2885
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get my Tyan board (AMD 81x1 chipset) to go to sleep such
that wake-on-LAN will wake it back up.  On my other machines, when I
shutdown -h, it (presumably) puts the machine into S5 state
automatically, and WOL works like a charm; on this machine, shutdown -h
  puts the machine into an actual "off" state in which WOL won't wake it
back up.

Moreover, if I try to echo 5 > /proc/acpi/sleep with full debugging, I
get absolutely nothing in dmesg.

Here are the ACPI-related lines from my boot log (minus the lines
regarding ACPI routing of specific IRQ's):

PCI: Using ACPI for IRQ routing
hpet_acpi_add: no address or irqs in _CRS
ACPI wakeup devices:
PCI1 USB0 USB1 PS2K GOLA GLAN GOLB SMBC AC97 MODM PWRB
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ACPI: 'PS2K' and 'PCI1' have the same GPE, can't disable/enable one
seperately
ACPI: 'GLAN' and 'PCI1' have the same GPE, can't disable/enable one
seperately

/proc/acpi/wakeup:

Device  Sleep state     Status
PCI1       4             enabled
USB0       4            disabled
USB1       4            disabled
PS2K       1             enabled
GOLA       4            disabled
GLAN       4             enabled
GOLB       4            disabled
SMBC       4            disabled
AC97       4            disabled
MODM       4            disabled
PWRB       1            *enabled


and /proc/acpi/sleep:

S0 S1 S4 S5

Furthermore, if I shut down from Windows, it *does* go into what I
presume is the S5 state, so this is a software problem, not hardware.

Any suggestions on debugging?

Cheers,
Kyle
