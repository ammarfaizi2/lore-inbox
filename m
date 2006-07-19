Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWGSKzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWGSKzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 06:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWGSKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 06:55:48 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:3740 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S964790AbWGSKzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 06:55:47 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: 2.6.18-rc2 tg3  Dead loop on netdevice eth0 fix it urgently!
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060719090407.GI23431@puettmann.net>
References: <20060719090407.GI23431@puettmann.net>
Content-Type: text/plain; charset=utf-8
Date: Wed, 19 Jul 2006 11:55:45 +0100
Message-Id: <1153306545.2702.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have this same problem 
dmesg | grep -i lost 
have you lost tickets ? 

You may open a bug in bugzilla http://bugme.osdl.org/ and include your
dmesg 

--
Sérgio M. B.

On Wed, 2006-07-19 at 11:04 +0200, Ruben Puettmann wrote:
>         hy,
> 
> i have here 2 DL585 with kernel 2.6.18-rc2 on Debian Etch. 
> Kernel Config is attached. I got massiv Problems on the Ethernet. 
> The only Information I got ist :
> 
> Dead loop on netdevice eth0, fix it urgently!
> Dead loop on netdevice eth0, fix it urgently!
> Dead loop on netdevice eth0, fix it urgently!
> Dead loop on netdevice eth0, fix it urgently!
> 
> 
> 
> lspci:
> 
> root@test:[~] > lspci
> 00:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
> 00:04.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
> 00:04.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
> 00:04.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
> 00:07.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 00:07.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:08.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 00:08.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> 01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> 01:02.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Controller (rev 01)
> 01:02.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Processor (rev 01)
> 01:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 02:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
> 02:06.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
> 04:09.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 04:09.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 04:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 04:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 04:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 04:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 04:0c.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
> 04:0c.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 05:0d.0 RAID bus controller: Hewlett-Packard Company Hewlett-Packard Smart Array P600
> root@test:[~] > 
> 
> 
> root@test:[~] > cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       
>   0:        482         34      22438         18       4310      35266   21635089      11711    IO-APIC-edge  timer
>   1:          0          0          0          0          0          0         11          0    IO-APIC-edge  i8042
>   3:          0          1          0          0          1          0          0          0    IO-APIC-edge  serial
>   4:          0          0          0          0          0          0          8          0    IO-APIC-edge  serial
>   6:          0          0          0          0          0          0          3          0    IO-APIC-edge  floppy
>   8:          0          0          0          0          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0          0          0          0          0   IO-APIC-level  acpi
>  12:          0          0          0          0          0          0        206          0    IO-APIC-edge  i8042
>  14:          0          0          0          0          0          0         12          0    IO-APIC-edge  ide0
> 169:         10          1         31        763       4408      10729       5474    3936296   IO-APIC-level  cciss0
> 177:         37         88      21943         66      10208      85684   38962854      38671   IO-APIC-level  eth0
> 185:         82         68       7165         99     333595     109518   18703688      22269   IO-APIC-level  eth1
> NMI:        851        791       2983       2378        878       1251      11185       6284 
> LOC:   21710514   21710492   21710467   21710443   21710419   21710395   21710371   21710347 
> ERR:          0
> MIS:          0
> 
> 
> 
> 
> 

