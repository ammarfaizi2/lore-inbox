Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSGSVng>; Fri, 19 Jul 2002 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGSVng>; Fri, 19 Jul 2002 17:43:36 -0400
Received: from mail.sneakemail.com ([207.106.87.13]:37007 "HELO
	mail.sneakemail.com") by vger.kernel.org with SMTP
	id <S317110AbSGSVn3>; Fri, 19 Jul 2002 17:43:29 -0400
Message-ID: <195160491.1027115172865.JavaMail.root@monkey>
Date: 19 Jul 2002 17:46:10 -0000
From: "david" <wb6kgd001@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.26 APIC BUG when booting Xeon box
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon compiling 2.5.26 on a 4-CPU 1.6GHz Pentium Xeon box, I get the message "kernel BUG at smpboot.c:1128!"

Below is the statement that triggers the oops:
	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
		BUG();

This occurs both with Hyper-Threading on and off in the BIOS, and with CONFIG_PENTIUMIII and CONFIG_PENTIUM4.  Note that 2.4.x kernels boot fine.

/proc/cpuinfo is below.  Please cc: me on replies.

Thanks,

David
--------------------------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Genuine CPU 1.60GHz
stepping	: 1
cpu MHz		: 1594.859
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3185.04
