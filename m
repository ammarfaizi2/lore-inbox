Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130774AbQKYLiQ>; Sat, 25 Nov 2000 06:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130771AbQKYLiH>; Sat, 25 Nov 2000 06:38:07 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48654 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S130614AbQKYLhw>;
        Sat, 25 Nov 2000 06:37:52 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess 
In-Reply-To: Your message of "Sat, 25 Nov 2000 05:26:20 CDT."
             <200011251026.eAPAQKG210983@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Nov 2000 22:07:44 +1100
Message-ID: <6551.975150464@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000 05:26:20 -0500 (EST), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>Somebody else posted a reasonable hack for the [<>] problem.
>His proposal involved letting multiple values share the same
>markers, something like this:
>
>[<c19a5cb4 c180234c c1801134 c1706550 c1800248 c1603310 c1934878 c1840324>]

What happens if the line is wrapped before being fed to ksymoops?  That
happens quite often.  What happens with the IKD patch which adds values
between the addresses from stack?  Why am I even bothering to reply to
these messages?

Trying to shrink the oops log to fit on a screen is an exercise in
futility.  How do you propose to make this IA64 oops fit on 80x24?

Unable to handle kernel paging request at virtual address 0000000000000000
modprobe[301]: Oops 8804682956800
psr : 0000101008026030 ifs : 8000000000000184 ip  : [<a000000000018100>]
unat: 0000000000000000 pfs : 0000000000000184 rsc : 0000000000000003
rnat: e00000003c727d60 bsps: e00000003c720000 pr  : 00000000000ae693
ldrs: 0000000000000000 ccv : 0000000000000001 fpsr: 0009804c0270033f
b0  : a0000000000180f0 b6  : e0000000008487a0 b7  : e000000000521030
f6  : 1003e00000000000000a0 f7  : 1003e00000000000000a0
f8  : 1003e0000000000000005 f9  : 10002a000000000000000
r1  : a000000000018358 r2  : 0000000000000917 r3  : 00000000000000ff
r8  : 000000000000000d r9  : 6000000000024d30 r10 : 6000000000028d30
r11 : c00000000000040a r12 : e00000003c727da0 r13 : e00000003c720000
r14 : 0000000000000000 r15 : e00000003c720028 r16 : e00000003c720000
r17 : 0000000000000064 r18 : e000000000990240 r19 : e00000003c720098
r20 : 000000000000ff00 r21 : 0000000000000fff r22 : e000000000aeff20
r23 : 0000001008022030 r24 : a000000000018240 r25 : a000000000018398
r26 : 6000000000024e88 r27 : a000000000018398 r28 : 00000000000002d8
r29 : a000000000018398 r30 : 6000000000024e88 r31 : 0000000000000917
r32 : 0000000000000000 r33 : 0000000000000000 r34 : 0000000000000000
r35 : 0000000000000000
Call Trace: [<e0000000005267a0>] [<e000000000526f60>] [<e000000000531ae0>] [<e00000000054a4a0>]
[<e000000000521520>] [<a000000000018100>] [<a0000000000180f0>]
[<a0000000000180f0>] [<a0000000000180f0>] [<a0000000000180f0>]
[<a0000000000180f0>] [<a0000000000180f0>] [<a0000000000180f0>]
[<a0000000000180f0>] [<a0000000000180f0>] [<a0000000000180f0>]
[<a0000000000180f0>] [<a0000000000180f0>] [<a0000000000180f0>]
[<a0000000000180f0>]

Or this one from arm?  Even without markers it is 82x47.

Unable to handle kernel paging request at virtual address 42062dd4
current->tss.memmap = 039DC000
*pgd = 00000000, *pmd = 00000000
Internal error: Oops: 0
CPU: 0
pc : [<c00160c8>]    lr : [<c0016354>]
sp : c3813e88  ip : c3813ebc  fp : c3813eb8
r10: 00000000  r9 : 00000004  r8 : 00000002
r7 : c3813ed4  r6 : e5832000  r5 : 00000000  r4 : 42062dd3
r3 : 00000000  r2 : 00000000  r1 : 00000003  r0 : c3813ed4
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 39DD17F  Table: 039DD17F  DAC: 00000015
Process insmod (pid: 267, stackpage=c3813000)
Stack: 
c3813e60:                                                        c0016354 c00160c8 
c3813e80: 40000013 ffffffff 00000004 c3813e98  00000003 c3813ed4 00000003 00000000 
c3813ea0: ffffffea c4824094 42062dd3 c3813ed0  c3813ebc c0016354 c0015df4 ffffffff 
c3813ec0: c3813f08 c3813f30 c3813ed4 c000e7ec  c0016288 c01ccd80 c0134800 00000000 
c3813ee0: 42062dd3 00000000 c4824000 00000000  ffffffea c4824094 42062dd3 00000000 
c3813f00: c3813f30 c3813f34 c3813f1c c0020524  c482406c a0000013 ffffffff c4824094 
c3813f20: 42062dd3 c3813fb0 c3813f34 c0020524  c4824058 00000005 c3813f3c c32c8000 
c3813f40: c32d6000 00000048 c4815000 c4824048  00000094 00000000 00000000 00000000 
c3813f60: 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00000000 
c3813f80: 00000000 00000000 00000000 0205ce98  c3812000 00000080 60000013 c3813ff4 
c3813fa0: 00000000 00000000 c3813fb4 c000ec0c  c001ff24 0205ce98 0205ce98 02062d40 
c3813fc0: 00000000 00000000 0205ce98 bffffd94  020000c0 0204ab08 020001ac 00000000 
c3813fe0: 00000000 bffffc74 02062d40 bffffc58  02003a54 020080b8 60000010 0205ce98 
Backtrace: 
Function entered at [<c0015de8>] from [<c0016354>]
  r9 = 42062dd3
  r8 = c4824094
  r7 = ffffffea
  r6 = 00000000
  r5 = 00000003
  r4 = c3813ed4
Function entered at [<c001627c>] from [<c000e7ec>]
  r5 = c3813f08
  r4 = ffffffff
Function entered at [<c482404c>] from [<c0020524>]
Function entered at [<c001ff18>] from [<c000ec0c>]
  r9 = 00000000
  r8 = c3813ff4
  r7 = 60000013
  r6 = 00000080
  r5 = c3812000
  r4 = 0205ce98
Code: e7973108 e1a02423 (e5c42001) e5c43000 e1a02823 

Or this one from sparc, 106x26?  No, you cannot merge the callers onto
multiple lines, on some traces the caller address is followed by the
parameters to the function.

Warning: kfree_skb passed an skb still on a list (from f00eb568).
Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>tsk->mm->context = 00000172
tsk->mm->pgd = f8569400
rpc.nfsd(374): Oops
PSR: 40400fc1 PC: f00929f4 NPC: f00929f8 Y: 00000000
g0: 40000fc3 g1: 40400fe2 g2: f0196000 g3: fd002010 g4: 00000000 g5: 000186b5 g6: f8562000 g7: 00000050
o0: 00000001 o1: 00000000 o2: 0000000e o3: ee7794b2 o4: 00000100 o5: ee7795f4 sp: f8563918 o7: f00929cc
l0: f014c204 l1: f012de68 l2: 40400fe2 l3: f0187910 l4: 00000000 l5: f0145664 l6: f8562000 l7: 00000002
i0: e56df2c0 i1: f0151d54 i2: 000000b0 i3: ff000000 i4: 00000078 i5: f011e388 fp: f8563980 i7: f00eb86c
Caller[f00eb86c]
Caller[f001a74c]
Caller[f001654c]
Caller[f00167d0]
Caller[f0034988]
Caller[f0027448]
Caller[f0027814]
Caller[f0016fcc]
Caller[f00984f0]
Caller[f00985a0]
Caller[f0092aec]
Caller[f003b334]
Caller[f002fd4c]
Caller[f001806c]
Caller[00019444]
Instruction DUMP: e6260000  d2262004  f024e004 <f0224000> 4002389f  90100010  818ca000  01000000  01000000
Aiee, killing interrupt handler

If anybody really worries about the ix86 call trace going past column
80, just patch your kernel to print 5 fields per line instead of 8.  Do
not change the format.  But hand copying an oops from an 80x24 screen
is not going to work in the long term, see above.  Fiddling with the
output format is a waste of time, instead work out how to capture the
oops without relying on hand copying or a limited screen size.  Fix the
problem, not the symptom.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
