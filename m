Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283080AbRLEHNw>; Wed, 5 Dec 2001 02:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283114AbRLEHNn>; Wed, 5 Dec 2001 02:13:43 -0500
Received: from mxfw2.q-free.com ([62.92.116.9]:23304 "HELO mxfw2")
	by vger.kernel.org with SMTP id <S283080AbRLEHN1>;
	Wed, 5 Dec 2001 02:13:27 -0500
Message-ID: <3C0DC97D.8010503@q-free.com>
Date: Wed, 05 Dec 2001 18:15:09 +1100
From: Mathias Teikari <mathias.teikari@q-free.com>
Organization: Q-Free Australia Pty Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mathias Teikari <mathias.teikari@q-free.com>
Subject: Oops in d_lookup (dcache.c)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[not subscribed to the linux-kernel list; please CC. -Thanx!]

Hi,

We've experienced a couple of crashes where the ksymoops output appears
(to a kernel development layman as myself) to point to the directory
caching functionality. I haven't managed to pinpoint a reproduction
sequence though, it seems to be a random and rare occurance. The last
entry in the system log before the oops was some 16 hours earlier.

If anyone is interested in looking into this, I've collected some
information regarding the setup used.

Red Hat 7.1 (kernel 2.4.2-2) with a two physical disks in Raid 1
configuration.

I've captured the ksyms; however, not at the time of the crash, but the
modules are loaded under the same circumstances and in the same order.
The file is not attached (43k wouldn't go to nicely in the list!), but
it's archived in case it would be needed.

The same goes for the system map.

I've run ksymoops on the oops with the output below.

If you could give any indication as to what might have caused this
situation (and if there's a known cure!) it would be greatly appreciated.

Regards,
    Mathias Teikari


-- 
Mathias Teikari - Q-Free Australia Pty Ltd.
      < mathias.teikari@q-free.com >

--
Unit 17 / 1 Talavera Rd.
North Ryde 2113 NSW
Australia
--
Ph: +61 2 9887 8203
Fax: +61 2 9888 6800
Mob: +61 415 187 918


-----
ksymoops 2.4.0 on i586 2.4.2-2.  Options used
      -v /boot/vmlinux-2.4.2-2 (specified)
      -k ksyms.lane15 (specified)
      -l modules.lane15 (specified)
      -o /lib/modules/2.4.2-2/ (default)
      -m System.map (specified)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01b0440, vmlinux says c0152e10.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol mxsercfg  , mxser says
c486c940, /lib/modules/2.4.2-2/kernel/drivers/char/mxser.o says
c486c7a0.  Ignoring /lib/modules/2.4.2-2/kernel/drivers/char/mxser.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd
says c484e794, /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o says
c484dbfc.  Ignoring /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
c484e790, /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o says c484dbf8.
Ignoring /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says
c484e798, /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o says c484dc00.
Ignoring /lib/modules/2.4.2-2/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
c48403e0, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c48400a0.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
c48403e4, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c48400a4.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
c48403e8, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c48400a8.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
c48403dc, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c484009c.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc
says c48403bc, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says
c484007c.  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
c48403ac, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c484006c.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
c48403c0, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c4840080.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says
c48403a4, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c4840064.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says
c48403a8, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c4840068.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says
c48403a0, /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o says c4840060.
  Ignoring /lib/modules/2.4.2-2/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol raid1_retry_tail  , raid1
says c4805358, /lib/raid1.o says c4805220.  Ignoring /lib/raid1.o entry
Nov 13 07:09:27 LCxLane15 kernel: Unable to handle kernel paging request
at virtual address e1ca6558
Nov 13 07:09:27 LCxLane15 kernel: c01457e4
Nov 13 07:09:27 LCxLane15 kernel: Oops: 0000
Nov 13 07:09:27 LCxLane15 kernel: CPU:    0
Nov 13 07:09:27 LCxLane15 kernel: EIP:    0010:[d_lookup+100/288]
Nov 13 07:09:27 LCxLane15 kernel: EIP:    0010:[<c01457e4>]
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 13 07:09:27 LCxLane15 kernel: EFLAGS: 00010202
Nov 13 07:09:27 LCxLane15 kernel: eax: c1110000   ebx: e1ca6540   ecx:
0000000d   edx: d66fc523
Nov 13 07:09:27 LCxLane15 kernel: esi: d66fc523   edi: c1bb7f10   ebp:
e1ca6558   esp: c1bb7eac
Nov 13 07:09:27 LCxLane15 kernel: ds: 0018   es: 0018   ss: 0018
Nov 13 07:09:27 LCxLane15 kernel: Process ps (pid: 28546,
stackpage=c1bb7000)
Nov 13 07:09:27 LCxLane15 kernel: Stack: c1119b00 c22f7008 d66fc523
00000006 c1bb7f10 c1bb7f7c c1bb7f10 c22f700e
Nov 13 07:09:27 LCxLane15 kernel:        c013d200 c20a47a0 c1bb7f10
c22f7008 c013da41 c20a47a0 c1bb7f10 00000000
Nov 13 07:09:27 LCxLane15 kernel:        c1bb7efc c1bb7efc 00000001
00000000 00000000 00000010 00000007 00000000
Nov 13 07:09:27 LCxLane15 kernel: Call Trace: [<d66fc523>]
[cached_lookup+16/80] [path_walk+1537/2240] [<d66fc523>]
[open_namei+151/1632] [dput+341/384] [filp_open+52/96]
Nov 13 07:09:27 LCxLane15 kernel: Call Trace: [<d66fc523>] [<c013d200>]
[<c013da41>] [<d66fc523>] [<c013e287>] [<c0144fe5>] [<c01329e4>]
Nov 13 07:09:27 LCxLane15 kernel:        [<c013cfcc>] [<c0132ce6>]
[<c0108fb3>]
Nov 13 07:09:27 LCxLane15 kernel: Code: 8b 6d 00 39 53 48 0f 85 90 00 00
00 8b 44 24 24 39 43 0c 0f


 >> EIP; c01457e4 <d_lookup+64/120> <=====

Trace; d66fc523 <END_OF_CODE+11e898b4/????>
Trace; d66fc523 <END_OF_CODE+11e898b4/????>
Trace; c013d200 <cached_lookup+10/50>
Trace; c013da41 <path_walk+601/8c0>
Trace; d66fc523 <END_OF_CODE+11e898b4/????>
Trace; c013e287 <open_namei+97/660>
Trace; c0144fe5 <dput+155/180>
Trace; c01329e4 <filp_open+34/60>
Trace; c013cfcc <getname+5c/a0>
Trace; c0132ce6 <sys_open+36/b0>
Trace; c0108fb3 <system_call+33/40>
Code;  c01457e4 <d_lookup+64/120>
00000000 <_EIP>:
Code;  c01457e4 <d_lookup+64/120> <=====
    0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c01457e7 <d_lookup+67/120>
3:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  c01457ea <d_lookup+6a/120>
6:   0f 85 90 00 00 00         jne    9c <_EIP+0x9c> c0145880
<d_lookup+100/120>
Code;  c01457f0 <d_lookup+70/120>
c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c01457f4 <d_lookup+74/120>
10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c01457f7 <d_lookup+77/120>
13:   0f 00 00                  sldt   (%eax)



