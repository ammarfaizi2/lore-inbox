Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVAXUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVAXUnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXUgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:36:49 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:64654 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261636AbVAXU2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:28:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=EvBONq6AX+zrtPnJgRTZAOE0r+h2NY1y5UGZCMm8d1NPv+9vSFGSW9GiBC1AtxqfynkCdSTvNPMEBCwKOlQKBvnOV6mU1kKR3huyLXHwbyBGBInBNpvdcbV6yeEYd3mDgCgqy+3wZsMwxxaOFlbmJC2ixHKlUwFNHfUTpq1kbrI=
Message-ID: <65258a5805012412287f6bfe71@mail.gmail.com>
Date: Mon, 24 Jan 2005 21:28:22 +0100
From: Vincent Vanackere <vincent.vanackere@gmail.com>
Reply-To: Vincent Vanackere <vincent.vanackere@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.11-rc1-mm1] Strange MCE errors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

since I've replaced my Athlon XP 1800 with a Athlon XP 3000
(Barton/FSB333), my logs are flooded with these warnings:

MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: d400400000000152
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: d40040000000017a

(If it has any importance, my motherboard is a Gigabyte 7VAXP-Ultra.
I've tried with another ram chip, but no change at all in behaviour)

Apart from that, this system is running flawlessly, so I'm tented to
just disable MCE in the kernel. But... I'd like to know if this is a
kernel mistake or if I have really some configuration/hardware
problem. I could not deduce anything meaningful from the parsemce
(version 0.09) utility.

Any help or advice would be apreciated...

Vincent

P.S.: here follows more information on this cpu
----------------------------------------------------------------------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 3000+
stepping        : 0
cpu MHz         : 2170.470
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 4292.60
------------------------------------------------------------------------
# cpuid
 eax in    eax      ebx      ecx      edx
00000000 00000001 68747541 444d4163 69746e65
00000001 000006a0 00000000 00000000 0383fbff
80000000 80000008 68747541 444d4163 69746e65
80000001 000007a0 00000000 00000000 c1c3fbff
80000002 20444d41 6c687441 74286e6f 5820296d
80000003 30332050 002b3030 00000000 00000000
80000004 00000000 00000000 00000000 00000000
80000005 0408ff08 ff20ff10 40020140 40020140
80000006 00000000 41004100 02008140 00000000
80000007 00000000 00000000 00000000 00000001
80000008 00002022 00000000 00000000 00000000

Vendor ID: "AuthenticAMD"; CPUID level 1

AMD-specific functions
Version 000006a0:
Family: 6 Model: 10 [Duron/Athlon model 10]

Standard feature flags 0383fbff:
Floating Point Unit
Virtual Mode Extensions
Debugging Extensions
Page Size Extensions
Time Stamp Counter (with RDTSC and CR4 disable bit)
Model Specific Registers with RDMSR & WRMSR
PAE - Page Address Extensions
Machine Check Exception
COMPXCHG8B Instruction
APIC
SYSCALL/SYSRET or SYSENTER/SYSEXIT instructions
MTRR - Memory Type Range Registers
Global paging extension
Machine Check Architecture
Conditional Move Instruction
PAT - Page Attribute Table
PSE-36 - Page Size Extensions
MMX instructions
FXSAVE/FXRSTOR
25 - reserved
Generation: 7 Model: 10
Extended feature flags c1c3fbff:
Floating Point Unit
Virtual Mode Extensions
Debugging Extensions
Page Size Extensions
Time Stamp Counter (with RDTSC and CR4 disable bit)
Model Specific Registers with RDMSR & WRMSR
PAE - Page Address Extensions
Machine Check Exception
COMPXCHG8B Instruction
APIC
SYSCALL/SYSRET or SYSENTER/SYSEXIT instructions
MTRR - Memory Type Range Registers
Global paging extension
Machine Check Architecture
Conditional Move Instruction
PAT - Page Attribute Table
PSE-36 - Page Size Extensions
AMD MMX Instruction Extensions
MMX instructions
FXSAVE/FXRSTOR
3DNow! Instruction Extensions
3DNow instructions

Processor name string: AMD Athlon(tm) XP 3000+
L1 Cache Information:
2/4-MB Pages:
   Data TLB: associativity 4-way #entries 8
   Instruction TLB: associativity 255-way #entries 8
4-KB Pages:
   Data TLB: associativity 255-way #entries 32
   Instruction TLB: associativity 255-way #entries 16
L1 Data cache:
   size 64 KB associativity 2-way lines per tag 1 line size 64
L1 Instruction cache:
   size 64 KB associativity 2-way lines per tag 1 line size 64

L2 Cache Information:
2/4-MB Pages:
   Data TLB: associativity L2 off #entries 0
   Instruction TLB: associativity L2 off #entries 0
4-KB Pages:
   Data TLB: associativity Direct mapped #entries 0
   Instruction TLB: associativity Direct mapped #entries 0
   size 2 KB associativity L2 off lines per tag 129 line size 64

Advanced Power Management Feature Flags
Has temperature sensing diode
Maximum linear address: 32; maximum phys address 34
