Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJILyA>; Tue, 9 Oct 2001 07:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276343AbRJILxv>; Tue, 9 Oct 2001 07:53:51 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:13704 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S276248AbRJILxh>; Tue, 9 Oct 2001 07:53:37 -0400
Message-Id: <1167435.cZxFsPTIob@newssend.sf-tec.de>
From: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Subject: 2.4.11-pre6: redefined & Unresolved symbols
To: linux-kernel@vger.kernel.org
Date: Tue, 09 Oct 2001 13:55:32 +0200
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is printed at least 50 times during make bzImage and make modules:

In file included from 
/usr/src/linux-2.4.11-pre6/drivers/acpi/include/platform/aclinux.h:56,
                 from 
/usr/src/linux-2.4.11-pre6/drivers/acpi/include/platform/acenv.h:109,
                 from 
/usr/src/linux-2.4.11-pre6/drivers/acpi/include/acpi.h:35,
                 from sm_osl.c:39:
/usr/src/linux-2.4.11-pre6/drivers/acpi/include/platform/acgcc.h:104: 
warning: `wbinvd' redefined
/usr/src/linux-2.4.11-pre6/include/asm/system.h:128: warning: this is 
the location of the previous definition

And this is of course from make modules

depmod: *** Unresolved symbols in 
/lib/modules/2.4.11-pre6/kernel/drivers/acpi/ospm/busmgr/ospm_busmgr.o
depmod:         acpi_ut_debug_print_raw
depmod:         acpi_ut_debug_print
depmod:         acpi_ut_status_exit
depmod:         acpi_ut_exit
depmod:         acpi_ut_trace
depmod: *** Unresolved symbols in 
/lib/modules/2.4.11-pre6/kernel/drivers/acpi/ospm/button/ospm_button.o
depmod:         acpi_ut_debug_print_raw
depmod:         acpi_ut_debug_print
depmod:         acpi_ut_status_exit
depmod:         acpi_ut_trace
depmod: *** Unresolved symbols in 
/lib/modules/2.4.11-pre6/kernel/drivers/acpi/ospm/processor/ospm_processor.o
depmod:         acpi_ut_debug_print_raw
depmod:         acpi_ut_debug_print
depmod:         acpi_ut_status_exit
depmod:         acpi_ut_trace
depmod: *** Unresolved symbols in 
/lib/modules/2.4.11-pre6/kernel/drivers/acpi/ospm/system/ospm_system.o
depmod:         acpi_ut_debug_print_raw
depmod:         acpi_ut_debug_print
depmod:         acpi_ut_status_exit
depmod:         acpi_ut_trace

It's a 2.4.11-pre6 without any modifications.

Eike Beer

