Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263093AbTCSQm5>; Wed, 19 Mar 2003 11:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbTCSQm5>; Wed, 19 Mar 2003 11:42:57 -0500
Received: from tag.witbe.net ([81.88.96.48]:29196 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S263089AbTCSQmR>;
	Wed, 19 Mar 2003 11:42:17 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Dave Jones'" <davej@codemonkey.org.uk>
Cc: "'Juha Poutiainen'" <pode@iki.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: L2 cache detection in Celeron 2GHz (P4 based)
Date: Wed, 19 Mar 2003 17:53:13 +0100
Message-ID: <013d01c2ee38$0812e330$6100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030319135841.GC28770@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>  > You can also add that the L1 detection doesn't seem to be correct
>  > either : 
>  > 0K Instruction cache, and 8K data cache for L1... This is not much
>  > for instruction, it seems it should be 12K...
> 
> That should be fixed in recent 2.4s (and not-so-recent 2.5s).
> What version are you seeing this problem on?

Quite a recent one : 2.4.20.

Here are the traces :

bash-2.05$ dmesg | grep -i L1 
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L1 I cache: 0K, L1 D cache: 8K
bash-2.05$ uname -a
Linux addx-01.PAR 2.4.20-watchdog #4 SMP Mon Mar 17 10:57:00 GMT 2003
i686 unknown

bash-2.05$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.00GHz
stepping        : 7
cpu MHz         : 2000.356
cache size      : 8 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3984.58

Regards,
Paul


