Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUEHWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUEHWgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEHWgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:36:06 -0400
Received: from 12-222-129-149.client.insightBB.com ([12.222.129.149]:51847
	"EHLO dualie.purdueriots.com") by vger.kernel.org with ESMTP
	id S264223AbUEHWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:35:40 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: BUG: 2.6.6-rc3 on SMP/SPARC64 (Sun E3000) & MD / ksymoops output
Date: Sat, 8 May 2004 17:35:38 -0500
User-Agent: KMail/1.6.2
References: <200405071049.14725.pat@computer-refuge.org>
In-Reply-To: <200405071049.14725.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405081735.38801.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Output from ksymoops is attached below.

On Friday 07 May 2004 10:49, you wrote:
> I've been trying to get 2.6.6-rc3 to work in SMP mode on my E3000
> without much success yet.  It boots fine with a uniprocessor kernel,
> but trying to enable SMP gives me this as the last few lines of the
> kernel messages (booted with -p early printk option):
>

ksymoops 2.4.9 on sparc64 2.4.26-sparc64-smp.  Options used
     -v /usr/src/linux-2.6.6-rc3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.26-sparc64-smp/ (default)
     -m /usr/src/linux-2.6.6-rc3/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8000040f000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f01603 TPC: 000000000044b704 TNPC: 000000000044b708 Y: 
000000d
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 00000000006c5c00 g1: 00000000000007f0 g2: 0000000000000000 g3: 
0000000000628
g4: 0000000000622000 g5: 0000000000000000 g6: 000000000061e000 g7: 
0000000000000
o0: 000000000000007d o1: 0000000000008000 o2: fffff8000005c440 o3: 
00000000006a0
o4: 0000000000621d98 o5: 0000000000000008 sp: 00000000006214e1 ret_pc: 
00000000c
l0: 00000000006a11b8 l1: 00000000006c7400 l2: 00000000006c5c00 l3: 
0000000000620
l4: 000000000000fe83 l5: 0000000000000003 l6: 0000000000000000 l7: 
0000000000620
i0: 0000000000622000 i1: 0000000000000002 i2: 00000000006a11b8 i3: 
fffff80000030
i4: 0000000000000001 i5: fffff8000003de98 i6: 00000000006215b1 i7: 
000000000068c


>>PC;  0044b704 <wake_up_forked_process+1e4/280>   <=====

>>g0; 006c5c00 <__log_buf+7d50/8000>
>>g4; 00622000 <init_task+0/580>
>>g6; 0061e000 <init_thread_union+0/4000>
>>o4; 00621d98 <init_thread_union+3d98/4000>
>>sp; 006214e1 <init_thread_union+34e1/4000>
>>l0; 006a11b8 <per_cpu__runqueues+0/1260>
>>l1; 006c7400 <uidhash_table+ef0/1000>
>>l2; 006c5c00 <__log_buf+7d50/8000>
>>i0; 00622000 <init_task+0/580>
>>i2; 006a11b8 <per_cpu__runqueues+0/1260>
>>i6; 006215b1 <init_thread_union+35b1/4000>

Instruction DUMP: 9a01e008  82006020  c2762038 <c4586008> c6706008  
82102001  c
Error (Oops_code_values): invalid value 0xc in Code line, must be 2, 4, 
8 or 16 digits, value ignored


Code;  0044b6f8 <wake_up_forked_process+1d8/280>
00000000 <_PC>:
Code;  0044b6f8 <wake_up_forked_process+1d8/280>
   0:   9a 01 e0 08       add  %g7, 8, %o5
Code;  0044b6fc <wake_up_forked_process+1dc/280>
   4:   82 00 60 20       add  %g1, 0x20, %g1
Code;  0044b700 <wake_up_forked_process+1e0/280>
   8:   c2 76 20 38       unknown
Code;  0044b704 <wake_up_forked_process+1e4/280>
   c:   c4 58 60 08       unknown
Code;  0044b708 <wake_up_forked_process+1e8/280>
  10:   c6 70 60 08       unknown
Code;  0044b70c <wake_up_forked_process+1ec/280>
  14:   82 10 20 01       mov  1, %g1

Kernel panic: Attempted to kill the idle task!

> ----------------------------------------------------------------
> CENTRAL: Detected 4 slot Enterprise system. cfreg[aa] cver[fc]
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
> FHC(board 5): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
> FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
> FHC(board 3): Version[1] PartID[fa0] Manuf[3e]
> Built 1 zonelists
> Kernel command line: root=/dev/sda1 ro -p
> PID hash table entries: 2048 (order 11: 32768 bytes)
> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff8000040f000
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(0): Oops [#1]
> TSTATE: 0000009980f01603 TPC: 000000000044b704 TNPC: 000000000044b708
> Y: 000000d TPC: <wake_up_forked_process+0x1e4/0x280>
> g0: 00000000006c5c00 g1: 00000000000007f0 g2: 0000000000000000 g3:
> 0000000000628 g4: 0000000000622000 g5: 0000000000000000 g6:
> 000000000061e000 g7: 0000000000000 o0: 000000000000007d o1:
> 0000000000008000 o2: fffff8000005c440 o3: 00000000006a0 o4:
> 0000000000621d98 o5: 0000000000000008 sp: 00000000006214e1 ret_pc:
> 00000000c RPC: <wake_up_forked_process+0x15c/0x280>
> l0: 00000000006a11b8 l1: 00000000006c7400 l2: 00000000006c5c00 l3:
> 0000000000620 l4: 000000000000fe83 l5: 0000000000000003 l6:
> 0000000000000000 l7: 0000000000620 i0: 0000000000622000 i1:
> 0000000000000002 i2: 00000000006a11b8 i3: fffff80000030 i4:
> 0000000000000001 i5: fffff8000003de98 i6: 00000000006215b1 i7:
> 000000000068c I7: <sched_init+0x12c/0x1a0>
> Instruction DUMP: 9a01e008  82006020  c2762038 <c4586008> c6706008 
> 82102001  c Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing
>  <0>Press L1-A to return to the boot prom
> ---------------------------
>
> I've posted my .config, System.map, (uniproc) dmesg (from klogd), and
> (2.4.26) /proc/cpuinfo files to:
> http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.config
> http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.System.map
> http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.dmesg
> http://x-ray.rcs.purdue.edu/linux-2.4.26-e3000.cpuinfo
>
> I have not yet tested any other versions on it.
>
> Also, I've noticed the md driver seems to have problems with data
> corruption (it overwrites other partitions on the same disk, or the
> disklabel even).  I've noticed this problem under 2.6.5 on my Sun
> Ultra 60, as well.  Is it an UltrSparc issue, or is it more general?
>
> Pat

-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
