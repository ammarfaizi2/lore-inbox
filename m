Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTBFJ36>; Thu, 6 Feb 2003 04:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTBFJ36>; Thu, 6 Feb 2003 04:29:58 -0500
Received: from port.lamport.ru ([193.111.92.50]:45577 "HELO port.lamport.ru")
	by vger.kernel.org with SMTP id <S265816AbTBFJ3z>;
	Thu, 6 Feb 2003 04:29:55 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.21pre4aa1 - hard lockup (PCnet32 related?).
Date: Thu, 6 Feb 2003 12:39:35 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030131014020.GA8395@dualathlon.random> <20030205231627.GS19678@dualathlon.random> <3E419CB8.5090601@rackable.com>
In-Reply-To: <3E419CB8.5090601@rackable.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302061239.35263.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

About 4 hours of heavy load on 2 of my boxs lead to hard lockup.

Before the lockup there are a lot of messages like:
"eth0: Bus master arbitration failure, status ffff"

There is no such problems on 2.4.18rc2aa1 and 2.4.19rc1aa2

Both Systems are IBM Netfinity 5100.

[rathamahata@bo linux]$ /sbin/lspci
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:03.0 SCSI storage controller: Adaptec 7899P (rev 01)
01:03.1 SCSI storage controller: Adaptec 7899P (rev 01)
01:05.0 RAID bus controller: IBM Netfinity ServeRAID controller

[rathamahata@bo linux]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 996.758
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 996.758
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
