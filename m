Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSEAWn1>; Wed, 1 May 2002 18:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEAWn0>; Wed, 1 May 2002 18:43:26 -0400
Received: from ns3.efi.com ([192.68.228.82]:3346 "HELO fcexgw03.efi.internal")
	by vger.kernel.org with SMTP id <S314077AbSEAWnZ>;
	Wed, 1 May 2002 18:43:25 -0400
Subject: 2.4.19-pre7 -- Oops on Alpha SMP
From: Frederic Roussel <frederic.roussel@efi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 01 May 2002 15:43:15 -0700
Message-Id: <1020292999.10057.28.camel@frasc>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried 2.4.19-pre7 on a dual pro Alpha (Compag DS20)

Anyone has an idea of what can be done ?

Thanks a lot.

cpuinfo: (reported by 2.2.18)
--------
cpu                     : Alpha
cpu model               : EV6
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Tsunami
system variation        : DP264
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 500000000 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 994.05
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 3285 (pc=120025688,va=12009bd84)
platform string         : AlphaPC 264DP 500 MHz
cpus detected           : 2
CPUs probed 2 active 2 map 0x3 IPIs 4552

oops:
----
Unable to handle kernel paging request at virtual address
08000b5608000b56
CPU 0 swapper(0): Oops 0
pc = [<fffffc00004c6cf8>]  ra = [<fffffc00004c73ac>]  ps = 0000    Not
tainted
v0 = fffffc0000511040  t0 = 0000040000000000  t1 = 08000b5608000b56
t2 = 00000400000005d0  t3 = 0000000000003ff0  t4 = fffffc0000569580
t5 = fffffc00005bdb38  t6 = 0000000000000100  t7 = fffffc000050c000
s0 = fffffc000053dd00  s1 = fffffc00005bdc08  s2 = 0000000000000000
s3 = fffffc0000542d80  s4 = 0000000000000000  s5 = fffffc0000478aa0
s6 = fffffc000045e7f8
a0 = 0000000000000000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = fffffc000050ffb0  a4 = 0000000000000008  a5 = 0000000000000000
t8 = 0000000000008000  t9 = 0000000000007fff  t10= 0000000000000078
t11= 0000000000000008  pv = fffffc00004aa960  at = 0000000000000001
gp = fffffc000059b6e0  sp = fffffc000050ff70
Trace:fffffc000045ee80 fffffc000031001c 
Code: 48255721  20913ff0  b75e0000  b55e0010  47f0040b  40610403
<a6c20000> a4bd
92e0 

>>RA;  fffffc00004c73ac <smp_boot_cpus+ec/2e0>

>>PC;  fffffc00004c6cf8 <secondary_cpu_start+38/160>   <=====

Trace; fffffc000045ee80 <unlink_from_pool+260/3c0>
Trace; fffffc000031001c <_stext+1c/20>

Code;  fffffc00004c6ce0 <secondary_cpu_start+20/160>
0000000000000000 <_PC>:
Code;  fffffc00004c6ce0 <secondary_cpu_start+20/160>
   0:   21 57 25 48       sll  t0,0x2a,t0
Code;  fffffc00004c6ce4 <secondary_cpu_start+24/160>
   4:   f0 3f 91 20       lda  t3,16368(a1)
Code;  fffffc00004c6ce8 <secondary_cpu_start+28/160>
   8:   00 00 5e b7       stq  ra,0(sp)
Code;  fffffc00004c6cec <secondary_cpu_start+2c/160>
   c:   10 00 5e b5       stq  s1,16(sp)
Code;  fffffc00004c6cf0 <secondary_cpu_start+30/160>
  10:   0b 04 f0 47       mov  a0,s2
Code;  fffffc00004c6cf4 <secondary_cpu_start+34/160>
  14:   03 04 61 40       addq t2,t0,t2
Code;  fffffc00004c6cf8 <secondary_cpu_start+38/160>   <=====
  18:   00 00 c2 a6       ldq  t8,0(t1)   <=====
Code;  fffffc00004c6cfc <secondary_cpu_start+3c/160>
  1c:   bd a4 00 00       call_pal     0xa4bd

-- 
Frederic.R.Roussel         -o)                                    (o-
OS Group Manager           /\\  Join the penguin force  (o_  (o_  //\
                          _\_v   The Linux G3N3R47!0N   (/)_ (/)_ v_/_


