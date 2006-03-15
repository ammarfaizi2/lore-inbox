Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWCOPoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWCOPoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWCOPoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:44:22 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:29150 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1751973AbWCOPoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:44:22 -0500
Date: Wed, 15 Mar 2006 16:44:05 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle  it
 on 2.6.16-rc6
In-Reply-To: <200603150553_MC3-1-BAB1-7C5A@compuserve.com>
Message-ID: <Pine.LNX.4.64.0603151622580.6328@bizon.gios.gov.pl>
References: <200603150553_MC3-1-BAB1-7C5A@compuserve.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1179346788-1142437445=:6328"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1179346788-1142437445=:6328
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 15 Mar 2006, Chuck Ebbert wrote:

> In-Reply-To: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
>
> On Sun, 12 Mar 2006 03:04:40 +0100, Krzysztof Oledzki wrote:
>
>> After upgrading to 2.6.16-rc6 I noticed this strange message:
>>
>> More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>> Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
>>
>> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so wi=
th
>> totoal of 4 logical CPUs).
>
> In a later message, you wrote:
>
>> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>> Processor #0 15:4 APIC version 20
>> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
>> Processor #6 15:4 APIC version 20
>             ^
>> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
>> Processor #1 15:4 APIC version 20
>> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
>> Processor #7 15:4 APIC version 20
>             ^
>
> What processor numbers did you get on 2.6.15.x?

Mar  6 00:08:03 fw2 kernel: Processor #0 15:4 APIC version 20
Mar  6 00:08:03 fw2 kernel: Processor #6 15:4 APIC version 20
Mar  6 00:08:03 fw2 kernel: Processor #1 15:4 APIC version 20
Mar  6 00:08:03 fw2 kernel: Processor #7 15:4 APIC version 20


> Does /proc/cpuinfo show all four CPUs?
Yes.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6404.87

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.28

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 2800.000
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.31

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 2800.000
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.32


> If you start four CPU-hungry processes, do all four show 100% utilization=
 in top(1)?

# cd /usr/src/linux
# /usr/bin/time make -j10=20
(...)

Cpu0  : 94.4% us,  5.3% sy,  0.0% ni,  0.3% id,  0.0% wa,  0.0% hi,  0.0% s=
i
Cpu1  : 92.4% us,  5.3% sy,  0.0% ni,  2.3% id,  0.0% wa,  0.0% hi,  0.0% s=
i
Cpu2  : 91.7% us,  6.6% sy,  0.0% ni,  0.3% id,  1.3% wa,  0.0% hi,  0.0% s=
i
Cpu3  : 94.7% us,  5.3% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% s=
i


Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1179346788-1142437445=:6328--
