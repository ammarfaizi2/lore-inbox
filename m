Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbTDPGWm (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTDPGWm 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:22:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:61671 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264247AbTDPGWj convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 02:22:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.5.x - acpi doesn't like my power status
Date: Wed, 16 Apr 2003 14:34:23 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8427228E@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.x - acpi doesn't like my power status
Thread-Index: AcLj4sXKh8nDFSYdQQ6lRwxTF9WDaQf/xj6w
From: "Yu, Luming" <luming.yu@intel.com>
To: "CaT" <cat@zip.com.au>, "Grover, Andrew" <andrew.grover@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 16 Apr 2003 06:34:24.0267 (UTC) FILETIME=[388B95B0:01C303E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cat /proc/acpi/dsdt to me

Thanks,
Luming


-----Original Message-----
From: CaT [mailto:cat@zip.com.au]
Sent: 2003?3?6? 21:16
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
Subject: 2.5.x - acpi doesn't like my power status


ACPI works on my laptop except for one major thing. The AC and battery
status never gets reported. On bootup the kernel spits out the
following:

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6a90
ACPI: RSDT (v001 PTLTD    RSDT   01540.00001) @ 0x0fff9b81
ACPI: FADT (v001 GATEWA SOLO5300 01540.00001) @ 0x0ffffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00001) @ 0x0ffffbd9
ACPI: DSDT (v001 GATEWA SOLO5300 01540.00001) @ 0x00000000
ACPI: BIOS passes blacklist
...
ACPI: Subsystem revision 20030228
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:...................................................................................................................
Table [DSDT] - 578 Objects with 50 Devices 115 Methods 29 Regions
ACPI Namespace successfully loaded at root c062a5bc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000800C
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:....[ACPI Debug] String:
ISA_INI
[ACPI Debug] String: LPT Decode Enabled At Boot
[ACPI Debug] Integer: 0000000000000378
[ACPI Debug] String: COM1 Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F8
[ACPI Debug] String: FDC Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F0
[ACPI Debug] String: General-Purpose Decode #12 Enabled At Boot
[ACPI Debug] Integer: 000000000000FE00
[ACPI Debug] String: General-Purpose Decode #13 Enabled At Boot
[ACPI Debug] Integer: 0000000000000398
...................................[ACPI Debug] String: MOON_2 Status
......
45 Devices found containing: 45 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................................................
Initialized 22/29 Regions 4/4 Fields 31/31 Buffers 30/34 Packages (578 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: Embedded Controller [EC0] (gpe 9)
[ACPI Debug] String: MOON_2 Status
[ACPI Debug] String: MOON_2 Status
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.AC0_._STA] (Node cff7ee
54), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETE
R
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node cff7d2
8c), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETE
R
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node cff7d7
6c), AE_BAD_PARAMETER

And on unplugging and plugging in the power I get the following:

evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [25] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER

Would it be possible to get power status support in? :)

Oh yeah. Relevant .config options:

# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

Thanks. (not on the acpi-devel list btw... 1000 msgs/day is enough for
me :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
