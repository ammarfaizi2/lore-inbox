Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHUFER>; Wed, 21 Aug 2002 01:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHUFER>; Wed, 21 Aug 2002 01:04:17 -0400
Received: from morannon.wetafx.co.nz ([203.98.17.18]:53205 "EHLO
	morannon.wetafx.co.nz") by vger.kernel.org with ESMTP
	id <S317874AbSHUFEP>; Wed, 21 Aug 2002 01:04:15 -0400
Subject: Re: Linux Kernel Crash - Vanilla 2.4.18/Redhat 2.4.18-5
From: Aaron Caskey <filburt@wetafx.co.nz>
To: Aaron Caskey <filburt@wetafx.co.nz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029386120.22139.32.camel@ruby>
References: <1029386120.22139.32.camel@ruby>
Content-Type: multipart/mixed; boundary="=-C+Oc9NObJR1P/UrUUxS0"
X-Mailer: Evolution/1.0.2 
Date: 21 Aug 2002 17:08:19 +1200
Message-Id: <1029906499.16242.26.camel@ruby>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C+Oc9NObJR1P/UrUUxS0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've attached a dump from one of the more recent 2.4.18 Kernels we are
now using.


On Thu, 2002-08-15 at 16:35, Aaron Caskey wrote:
> Sorry about before, rtfm etc, etc.
> 
> We are having oops crashes on a lot of our renderwall machines running 
> 2.4.18 with SGI's xfs 1.0.1 patch (although xfs support is disabled) and
> redhat 2.4.18-5 (our current production Kernel) with a system call
> reporting patch (I'm not sure on the name or version).
> 
> I've included 2 oops crash logs (expanded now) from the vanilla 2.4.18
> kernel, we get identical crashes on the RedHat kernels. I have to hand
> copy these because it kills the machine dead, when I catch a dead redhat
> machine I'll email the oops dump from that too.
> 
> The machines hardware is as follows:
> 2 2.2Ghz Xeon Processors
> 4G registered ECC DDR RAM
> Tyan e7500 Motherboard
> AMI Bios Rev 1.01
> 
> ide HDD with ext3 filesystem
> 
> Any help would be appreciated greatly.
> Thank You.
> -- 
> Kind Regards
> 
> Aaron Caskey
> Wrender Wrangler
> -----------------
>  /----------------------------------------\
>  | If animals were not meant to be eaten, |
>  | why are they made out of meat?         |
>  \---\ /----------------------------------/
>      /
>  |\_/|    
>  |o o|__  
>  --*--__\ 
>  C_C_(___)
> ----
> 

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

--=-C+Oc9NObJR1P/UrUUxS0
Content-Disposition: inline; filename=crashout3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

ksymoops 2.4.6 on i686 2.4.18-xfssmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfssmp/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c01c5050, System.map says c0160910.  Ignoring ksyms_base entry
Oops: 0000
CPU:    0
EIP:    0010:[<c5d40000>]    Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c5d41da8   ecx: c02e7f28   edx: 00000001
esi: c5d40000   edi: 00000000   ebp: c02e8334   esp: f7ff7ef4
ds: 0018   es: 0018   ss: 0018
Process ksoftirqd_CPU0 (pid: 3, stackpage=3Df7ff7000)
Stack: f88e0953 c5d41da8 c5d41da8 f88e08d0 c01222b7 c5d41da8 00000000 00000=
001
       00000000 c02e8334 c011e03b c02e8320 c011e2bc 00000000 00000005 c02c1=
500
       fffffffa 00000000 c011e03b c02c1500 00000046 0000000e c02bd9c0 00000=
00e
Call Trace: [<f88e0953>] [<f88e08d0>] [<c01222b7>] [<c011e3fb>] [<c011e2bc>=
]
   [<c011e03b>] [<c0108d1f>] [<c0116743>] [<c011e5bf>] [<c0105876>] [<c011e=
500>]
Code: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0 a0 04 26 c0


>>EIP; c5d40000 <_end+5a0908c/384d608c>   <=3D=3D=3D=3D=3D

>>ebx; c5d41da8 <_end+5a0ae34/384d608c>
>>ecx; c02e7f28 <irq_stat+8/400>
>>esi; c5d40000 <_end+5a0908c/384d608c>
>>ebp; c02e8334 <bh_task_vec+14/280>
>>esp; f7ff7ef4 <_end+37cc0f80/384d608c>

Trace; f88e0953 <[sunrpc]rpc_run_timer+83/90>
Trace; f88e08d0 <[sunrpc]rpc_run_timer+0/90>
Trace; c01222b7 <timer_bh+257/2b0>
Trace; c011e3fb <bh_action+4b/90>
Trace; c011e2bc <tasklet_hi_action+6c/a0>
Trace; c011e03b <do_softirq+7b/e0>
Trace; c0108d1f <do_IRQ+df/f0>
Trace; c0116743 <schedule+243/550>
Trace; c011e5bf <ksoftirqd+bf/110>
Trace; c0105876 <kernel_thread+26/30>
Trace; c011e500 <ksoftirqd+0/110>

Code;  c5d40000 <_end+5a0908c/384d608c>
00000000 <_EIP>:
Code;  c5d40000 <_end+5a0908c/384d608c>   <=3D=3D=3D=3D=3D
   0:   02 00                     add    (%eax),%al   <=3D=3D=3D=3D=3D
Code;  c5d4000e <_end+5a0909a/384d608c>
   e:   00 c0                     add    %al,%al
Code;  c5d40010 <_end+5a0909c/384d608c>
  10:   a0 04 26 c0 00            mov    0xc02604,%al

 <0>Kernel panic: Aiee, killing interupt handler!

1 warning issued.  Results may not be reliable.

--=-C+Oc9NObJR1P/UrUUxS0--

