Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTIDEFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDEFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:05:15 -0400
Received: from fmr09.intel.com ([192.52.57.35]:58063 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264605AbTIDEFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:05:03 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Date: Thu, 4 Sep 2003 00:04:58 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Thread-Index: AcNn2qNO8bWUvohNRy6XblgYOUj+AgKvmdgA
From: "Brown, Len" <len.brown@intel.com>
To: "Martin Mokrejs" <mmokrejs@natur.cuni.cz>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Sep 2003 04:04:59.0637 (UTC) FILETIME=[B5745A50:01C37299]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,
Does this still happen with 2.4.22?
If yes, can I trouble you to drop the info into bugzilla so we can put
it in the queue?

Thanks,
-Len
----
Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


> -----Original Message-----
> From: Martin Mokrejs [mailto:mmokrejs@natur.cuni.cz] 
> Sent: Thursday, August 21, 2003 12:15 PM
> To: linux-kernel@vger.kernel.org
> Subject: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
> 
> 
> Hi,
>   I observe time to time on cold boot hang of my laptop. I 
> remember to see 
> such hangs at least since 2.4.21-pre3. Here's my latest 
> running kernel:
> 
> # ksymoops --system-map=/boot/System.map-2.4.22-pre7 
> --vmlinux=/usr/src/linux-2.4.22-pre7/vmlinux ./cr
> ksymoops 2.4.9 on i686 2.4.22-pre7.  Options used
>      -v /usr/src/linux-2.4.22-pre7/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.22-pre7/ (default)
>      -m /boot/System.map-2.4.22-pre7 (specified)
> 
> EFLAGS: 00010246
> eax: 00000000 ebx: 638a05f0 ecx: 00000000 edx: 00000006
> esi: 638a05f0 edi: f7ebddd0 ebp: f7ebdd78 esp: f7ebdd74
> ds: 0018 es: 0018 ss: 0018
> Process keventd: (pid 2, stackpage=f7ebd000)
> Stack: f7ebdda4 f7ebdd90 c01ede68 638a05f0 f7ebdda4 f7ebddd0 
> 638a05f0 f7ebddc0
>        c01fc0f2 638a05f0 c01fc072 f7ebddd0 00010000 c0337755 
> c033770a 00000050
>        f7ebddd4 f7ebddd4 638a05f0 f7ebddf0 c02037c2 638a05f0 
> f7ebddd0 00000000
> Call Trace:     [<c01ede68>] [<c01fc0f2>] [<c01fc072>] 
> [<c02037c2>] [<c01f8a2a>]
>   [<c0203b8d>] [<c0203ee7>] [<c01fc4c7>] [<c01f8a00>] 
> [<c0207aed>] [<c0207e5e>]
>   [<c0208b60>] [<c01dce5a>] [<c01d4f7d>] [<c011ff0a>] 
> [<c01282e5>] [<c01281b0>]
>   [<c0105000>] [<c01057ee>] [<c01281b0>]
> Code: 80 3b aa 0f 44 c3 5b 5d c3 a1 d4 55 40 c0 eb f6 55 89 e5 8b
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> 
> >>edi; f7ebddd0 <_end+37a9304c/3a4f02dc>
> >>ebp; f7ebdd78 <_end+37a92ff4/3a4f02dc>
> >>esp; f7ebdd74 <_end+37a92ff0/3a4f02dc>
> 
> Trace; c01ede68 <acpi_get_data+34/60>
> Trace; c01fc0f2 <acpi_bus_get_device+45/a9>
> Trace; c01fc072 <acpi_bus_data_handler+0/3b>
> Trace; c02037c2 <acpi_power_get_context+46/a6>
> Trace; c01f8a2a <acpi_ut_trace+29/2b>
> Trace; c0203b8d <acpi_power_off_device+46/19d>
> Trace; c0203ee7 <acpi_power_transition+111/138>
> Trace; c01fc4c7 <acpi_bus_set_power+15f/273>
> Trace; c01f8a00 <acpi_ut_debug_print_raw+29/2a>
> Trace; c0207aed <acpi_thermal_active+bf/187>
> Trace; c0207e5e <acpi_thermal_check+295/2e2>
> Trace; c0208b60 <acpi_thermal_notify+a6/105>
> Trace; c01dce5a <acpi_ev_notify_dispatch+54/7a>
> Trace; c01d4f7d <acpi_os_execute_deferred+3a/6c>
> Trace; c011ff0a <__run_task_queue+5a/70>
> Trace; c01282e5 <context_thread+135/1d0>
> Trace; c01281b0 <context_thread+0/1d0>
> Trace; c0105000 <_stext+0/0>
> Trace; c01057ee <arch_kernel_thread+2e/40>
> Trace; c01281b0 <context_thread+0/1d0>
> 
