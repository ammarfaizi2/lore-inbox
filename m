Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbTCMWsW>; Thu, 13 Mar 2003 17:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbTCMWsW>; Thu, 13 Mar 2003 17:48:22 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28632 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262586AbTCMWsU>; Thu, 13 Mar 2003 17:48:20 -0500
Date: Thu, 13 Mar 2003 17:00:22 -0600
From: latten@austin.ibm.com
Message-Id: <200303132300.h2DN0M4k020390@faith.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: eth0: Bus master arbitration failure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if anyone knew if this had been resolved
or see this problem too. I am having the same problem. 
However, I am using 2.5.64 kernel and I have tried 
both an eepro100 and a 3com-tornado ethernet card.

I use netperf to create a load of packets, and within minutes
I receive a few "eth0: Bus master arbitration failure, status ffff"
and then the machine locks up. (This seems to only happen
with a heavy load.)

I have no problems when I use 2.4.18-3 smp kernel (Redhat 8.0)
and I have also used a 2.4.19 kernel a while back with no problems.

I am using a 2-way IBM Netfinity 4500 and a 4-way xSeries 350.
No problems on a uniprocessor.

Thanks, for any info.

Regards,
Joy

>Hello Andrea,
>About 4 hours of heavy load on 2 of my boxs lead to hard lockup.
>Before the lockup there are a lot of messages like:
>"eth0: Bus master arbitration failure, status ffff"
>There is no such problems on 2.4.18rc2aa1 and 2.4.19rc1aa2
>Both Systems are IBM Netfinity 5100.
>
>[rathamahata@bo linux]$ /sbin/lspci
>00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
>00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
>00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
>00:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
>00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
>00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
>00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
>01:03.0 SCSI storage controller: Adaptec 7899P (rev 01)
>01:03.1 SCSI storage controller: Adaptec 7899P (rev 01)
>01:05.0 RAID bus controller: IBM Netfinity ServeRAID controller
>
>[rathamahata@bo linux]$ cat /proc/cpuinfo
>processor : 0
>vendor_id : GenuineIntel
>cpu family : 6
>model : 8
>model name : Pentium III (Coppermine)
>stepping : 6
>cpu MHz : 996.758
>cache size : 256 KB
>fdiv_bug : no
>hlt_bug : no
>f00f_bug : no
>coma_bug : no
>fpu : yes
>fpu_exception : yes
>cpuid level : 2
>wp : yes
>flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
>bogomips : 1985.74
>
>processor : 1
>vendor_id : GenuineIntel
>cpu family : 6
>model : 8
>model name : Pentium III (Coppermine)
>stepping : 6
>cpu MHz : 996.758
>cache size : 256 KB
>fdiv_bug : no
>hlt_bug : no
>f00f_bug : no
>coma_bug : no
>fpu : yes
>fpu_exception : yes
>cpuid level : 2
>wp : yes
>flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
>bogomips : 1992.29
>
>-- 
>                   Best regards,
>                   Sergey S. Kostyliov <rathamahata@php4.ru>
>                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
