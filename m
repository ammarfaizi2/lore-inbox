Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTHVDX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 23:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTHVDXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 23:23:55 -0400
Received: from post.tau.ac.il ([132.66.16.11]:34767 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S263014AbTHVDXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 23:23:25 -0400
Subject: PROBLEM: compilling 2.6.0-test3-bk8 - apic/ioapic
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061510856.21487.38.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 22 Aug 2003 05:19:03 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.1; VDF: 6.21.0.26; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem compiling 2.6.0-test3-bk8 with acpi and local apic.
acpi without local apic returns compile error:

------
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:547: `skip_ioapic_setup' undeclared (first use
in this function)
------

with local apic, when fixing this problem I start getting  errors
concerning calls to ioapic functions:

------
arch/i386/kernel/mpparse.c:1067: warning: implicit declaration of
function `mp_find_ioapic'
arch/i386/kernel/mpparse.c:1069: `mp_ioapic_routing' undeclared (first
use in this function)
arch/i386/kernel/mpparse.c:1069: (Each undeclared identifier is reported
only once
arch/i386/kernel/mpparse.c:1069: for each function it appears in.)
arch/i386/kernel/mpparse.c:1071: warning: implicit declaration of
function `io_apic_set_pci_routing'
arch/i386/kernel/mpparse.c: In function `mp_parse_prt':
arch/i386/kernel/mpparse.c:1115: `mp_ioapic_routing' undeclared (first
use in this function)
-----

enabling ioapic (which I don't have) still doesn't work, after fixing
the first problem i get the same problem in

------
arch/i386/kernel/acpi/boot.c: In function `acpi_boot_init':
arch/i386/kernel/acpi/boot.c:426: `skip_ioapic_setup' undeclared (first
use in this function)
------

-- 
Micha Feigin
michf@math.tau.ac.il

