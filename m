Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277006AbRJDDiC>; Wed, 3 Oct 2001 23:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277100AbRJDDhx>; Wed, 3 Oct 2001 23:37:53 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:28612 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S277006AbRJDDhd>; Wed, 3 Oct 2001 23:37:33 -0400
Date: Wed, 3 Oct 2001 23:37:55 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Unresolved modules 2.4.10-ac4
Message-ID: <Pine.LNX.4.33.0110032310550.7092-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Received the following unresolved sysmbol messages after compiling acpi as
modules. They were received during make modules_install.

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac4/kernel/drivers/acpi/ospm/button/ospm_button.o

depmod: 	acpi_ut_debug_print_raw
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_trace

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac4/kernel/drivers/acpi/ospm/ec/ospm_ec.o

depmod: 	acpi_ut_debug_print_raw
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac4/kernel/drivers/acpi/ospm/processor/ospm_processor.o

depmod: 	acpi_ut_debug_print_raw
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_trace

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac4/kernel/drivers/acpi/ospm/system/ospm_system.o

depmod: 	acpi_ut_debug_print_raw
depmod: 	acpi_ut_debug_print
depmod: 	dmi_broken
depmod: 	init_8259A
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_trace

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac4/kernel/drivers/acpi/ospm/thermal/ospm_thermal.o

depmod: 	acpi_ut_debug_print_raw
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace

Kernel setup: 2.4.10 patched with 2.4.10-ac4

#define CONFIG_ACPI 1
#define CONFIG_ACPI_DEBUG 1
#undef  CONFIG_ACPI_BUSMGR
#define CONFIG_ACPI_BUSMGR_MODULE 1
#undef  CONFIG_ACPI_SYS
#define CONFIG_ACPI_SYS_MODULE 1
#undef  CONFIG_ACPI_CPU
#define CONFIG_ACPI_CPU_MODULE 1
#undef  CONFIG_ACPI_BUTTON
#define CONFIG_ACPI_BUTTON_MODULE 1
#undef  CONFIG_ACPI_AC
#undef  CONFIG_ACPI_EC
#define CONFIG_ACPI_EC_MODULE 1
#undef  CONFIG_ACPI_CMBATT
#undef  CONFIG_ACPI_THERMAL
#define CONFIG_ACPI_THERMAL_MODULE 1

At this point I went and redid the configuration but said "Y" to all ACPI
options that I had previously said "M". Now the compile went perfectly and
here is the kernel config:

#define CONFIG_ACPI 1
#define CONFIG_ACPI_DEBUG 1
#define CONFIG_ACPI_BUSMGR 1
#define CONFIG_ACPI_SYS 1
#define CONFIG_ACPI_CPU 1
#define CONFIG_ACPI_BUTTON 1
#undef  CONFIG_ACPI_AC
#define CONFIG_ACPI_EC 1
#undef  CONFIG_ACPI_CMBATT
#define CONFIG_ACPI_THERMAL 1

Hope this helps

Stephen

