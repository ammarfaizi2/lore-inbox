Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSHOEbb>; Thu, 15 Aug 2002 00:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHOEbb>; Thu, 15 Aug 2002 00:31:31 -0400
Received: from morannon.wetafx.co.nz ([203.98.17.18]:17130 "EHLO
	morannon.wetafx.co.nz") by vger.kernel.org with ESMTP
	id <S316542AbSHOEb3>; Thu, 15 Aug 2002 00:31:29 -0400
Subject: Linux Kernel Crash - Vanilla 2.4.18/Redhat 2.4.18-5 (2nd try =)  )
From: Aaron Caskey <filburt@wetafx.co.nz>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-BctZFPuJ114hLKMtMg5m"
X-Mailer: Evolution/1.0.2 
Date: 15 Aug 2002 16:35:20 +1200
Message-Id: <1029386120.22139.32.camel@ruby>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BctZFPuJ114hLKMtMg5m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry about before, rtfm etc, etc.

We are having oops crashes on a lot of our renderwall machines running 
2.4.18 with SGI's xfs 1.0.1 patch (although xfs support is disabled) and
redhat 2.4.18-5 (our current production Kernel) with a system call
reporting patch (I'm not sure on the name or version).

I've included 2 oops crash logs (expanded now) from the vanilla 2.4.18
kernel, we get identical crashes on the RedHat kernels. I have to hand
copy these because it kills the machine dead, when I catch a dead redhat
machine I'll email the oops dump from that too.

The machines hardware is as follows:
2 2.2Ghz Xeon Processors
4G registered ECC DDR RAM
Tyan e7500 Motherboard
AMI Bios Rev 1.01

ide HDD with ext3 filesystem

Any help would be appreciated greatly.
Thank You.
-- 
Kind Regards

Aaron Caskey
Wrender Wrangler
-----------------
 /----------------------------------------\
 | If animals were not meant to be eaten, |
 | why are they made out of meat?         |
 \---\ /----------------------------------/
     /
 |\_/|    
 |o o|__  
 --*--__\ 
 C_C_(___)

--=-BctZFPuJ114hLKMtMg5m
Content-Disposition: attachment; filename=crashout1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

ksymoops 2.4.6 on i686 2.4.18-xfssmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfssmp/ (default)
     -m /boot/System.map-2.4.18-xfssmp (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c01c5050, System.map says c0160910.  Ignoring ksyms_base entry
CPU:    0
EIP:    0010:[<00010202>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: d48fbc10   ecx: c02e7f28   edx: 00000001
esi: 00010202   edi: 00000000   ebp: 00000000   esp: f71f3d64
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 12, stackpage=3Df71f3000)
Stack: f88f1953 d48fbc10 d48fbc10 f88f18d0 c01222b7 d48fbc10 00000000 00000=
001
       00000000 00000000 c011e3fb c02e8320 c011e2bc 00000000 00000001 c02c1=
500
       fffffffe 00000000 c011e03b c02c1500 00000046 0000000e c02bd9c0 00000=
00e
Call Trace: [<f88f1953>] [<f88f18d0>] [<c01222b7>] [<c011e3fb>] [<c011e2bc>=
]
   [<c011e03b>] [<c0108d1f>] [<c011659a>] [<c013c076>] [<f881095d>] [<f880f=
b78>]
   [<f88127b6>] [<f8812660>] [<c0105876>] [<f8812680>]
Code:  Bad EIP value.


>>EIP; 00010202 Before first symbol   <=3D=3D=3D=3D=3D

>>ebx; d48fbc10 <_end+145c4c9c/384d608c>
>>ecx; c02e7f28 <irq_stat+8/400>
>>esp; f71f3d64 <_end+36ebcdf0/384d608c>

Trace; f88f1953 <[sunrpc]rpc_run_timer+83/90>
Trace; f88f18d0 <[sunrpc]rpc_run_timer+0/90>
Trace; c01222b7 <timer_bh+257/2b0>
Trace; c011e3fb <bh_action+4b/90>
Trace; c011e2bc <tasklet_hi_action+6c/a0>
Trace; c011e03b <do_softirq+7b/e0>
Trace; c0108d1f <do_IRQ+df/f0>
Trace; c011659a <schedule+9a/550>
Trace; c013c076 <__wait_on_buffer+76/a0>
Trace; f881095d <[jbd]journal_brelse_array+1d/30>
Trace; f880fb78 <[jbd]journal_commit_transaction+488/1123>
Trace; f88127b6 <[jbd]kjournald+136/1d0>
Trace; f8812660 <[jbd]commit_timeout+0/10>
Trace; c0105876 <kernel_thread+26/30>
Trace; f8812680 <[jbd]kjournald+0/1d0>

 <0>Kernel panic: Aiee, killing interupt handler!

1 warning issued.  Results may not be reliable.

--=-BctZFPuJ114hLKMtMg5m
Content-Disposition: attachment; filename=crashout2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

ksymoops 2.4.6 on i686 2.4.18-xfssmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfssmp/ (default)
     -m /boot/System.map-2.4.18-xfssmp (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c01c5050, System.map says c0160910.  Ignoring ksyms_base entry
CPU:    0
EIP:    0010:[<e57d6940>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cfc05bc0   ecx: c02e7f28   edx: 00000001
esi: e57d6940   edi: 00000000   ebp: 00000000   esp: f7ff9ef4
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 3, stackpage=3Df7ff9000)
Stack: f890f953 cfc05bc0 cfc05bc0 f890f8d0 c01222b7 cfc05bc0 00000000 00000=
001
       00000000 00000000 c011e3fb c02e8320 c011e2bc 00000000 00000007 c02c1=
500
       fffffff8 00000000 c011e03b c02c1500 00000046 0000000e c02bd9c0 00000=
00e
Call Trace: [<f890f953>] [<f890f8d0>] [<c01222b7>] [<c011e3fb>] [<c011e2bc>=
]
   [<c011e03b>] [<c0108d1f>] [<c0116743>] [<c011e5bf>] [<c0105876>] [<c011e=
500>]
Code:  c0 42 55 d2 98 e6 ef f5 00 e2 ef f5 00 00 47 f7 01 00 00 00=20


>>EIP; e57d6940 <_end+2549f9cc/384d608c>   <=3D=3D=3D=3D=3D

>>ebx; cfc05bc0 <_end+f8cec4c/384d608c>
>>ecx; c02e7f28 <irq_stat+8/400>
>>esi; e57d6940 <_end+2549f9cc/384d608c>
>>esp; f7ff9ef4 <_end+37cc2f80/384d608c>

Trace; f890f953 <[nfs]nfs_permission+53/119>
Trace; f890f8d0 <[nfs]nfs_rename+190/1c0>
Trace; c01222b7 <timer_bh+257/2b0>
Trace; c011e3fb <bh_action+4b/90>
Trace; c011e2bc <tasklet_hi_action+6c/a0>
Trace; c011e03b <do_softirq+7b/e0>
Trace; c0108d1f <do_IRQ+df/f0>
Trace; c0116743 <schedule+243/550>
Trace; c011e5bf <ksoftirqd+bf/110>
Trace; c0105876 <kernel_thread+26/30>
Trace; c011e500 <ksoftirqd+0/110>

Code;  e57d6940 <_end+2549f9cc/384d608c>
00000000 <_EIP>:
Code;  e57d6940 <_end+2549f9cc/384d608c>   <=3D=3D=3D=3D=3D
   0:   c0 42 55 d2               rolb   $0xd2,0x55(%edx)   <=3D=3D=3D=3D=
=3D
Code;  e57d6944 <_end+2549f9d0/384d608c>
   4:   98                        cwtl  =20
Code;  e57d6945 <_end+2549f9d1/384d608c>
   5:   e6 ef                     out    %al,$0xef
Code;  e57d6947 <_end+2549f9d3/384d608c>
   7:   f5                        cmc   =20
Code;  e57d6948 <_end+2549f9d4/384d608c>
   8:   00 e2                     add    %ah,%dl
Code;  e57d694a <_end+2549f9d6/384d608c>
   a:   ef                        out    %eax,(%dx)
Code;  e57d694b <_end+2549f9d7/384d608c>
   b:   f5                        cmc   =20
Code;  e57d694c <_end+2549f9d8/384d608c>
   c:   00 00                     add    %al,(%eax)
Code;  e57d694e <_end+2549f9da/384d608c>
   e:   47                        inc    %edi
Code;  e57d694f <_end+2549f9db/384d608c>
   f:   f7 01 00 00 00 00         testl  $0x0,(%ecx)

 <0>Kernel panic: Aiee, killing interupt handler!

1 warning issued.  Results may not be reliable.

--=-BctZFPuJ114hLKMtMg5m--

