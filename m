Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQJ2Sw2>; Sun, 29 Oct 2000 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130236AbQJ2SwR>; Sun, 29 Oct 2000 13:52:17 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:27776 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S129747AbQJ2SwJ>; Sun, 29 Oct 2000 13:52:09 -0500
Message-ID: <39FC71D8.12C4AA60@home.com>
Date: Sun, 29 Oct 2000 13:52:08 -0500
From: Arthur Pedyczak <arthur-p@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.0.-test9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have just gotten the following Oops. 
The system was working under significant load (CPU intensive computation
+ verification of a freshly burned CD).


============================================================================================
ksymoops 2.3.4 on i686 2.4.0-test9.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test9/ (default)
     -m /boot/System.map-2.4.0-test9 (specified)

Warning (compare_maps): ksyms_base symbol
sk_run_filter_R__ver_sk_run_filter not found in vmlinux.  Ignoring
ksyms_base entry
Oct 29 12:25:11 cs865114-a kernel: Unable to handle kernel paging
request at virtual address 486d1c60
Oct 29 12:25:11 cs865114-a kernel: c013fbf9
Oct 29 12:25:11 cs865114-a kernel: *pde = 00000000
Oct 29 12:25:11 cs865114-a kernel: Oops: 0002
Oct 29 12:25:11 cs865114-a kernel: CPU:    0
Oct 29 12:25:11 cs865114-a kernel: EIP:    0010:[prune_icache+157/232]
Oct 29 12:25:11 cs865114-a kernel: EFLAGS: 00013246
Oct 29 12:25:11 cs865114-a kernel: eax: c5c857c0   ebx: c854f348   ecx:
00000006   edx: 486d1c60
Oct 29 12:25:11 cs865114-a kernel: esi: c854f340   edi: c854f4c8   ebp:
c1455f70   esp: c1455f58
Oct 29 12:25:11 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Oct 29 12:25:11 cs865114-a kernel: Process kswapd (pid: 3,
stackpage=c1455000)
Oct 29 12:25:11 cs865114-a kernel: Stack: 00000006 00000000 00000000
00001ee6 c854f1c8 c7cd06a8 00000004 c013fc65 
Oct 29 12:25:11 cs865114-a kernel:        0000067f c0129795 00000006
00000004 00000006 00000004 0000018d 00000004 
Oct 29 12:25:11 cs865114-a kernel:        00000000 00000000 c1454000
0000001f 00000000 c012988a 00000004 00000000 
Oct 29 12:25:11 cs865114-a kernel: Call Trace:
[shrink_icache_memory+33/48] [refill_inactive+209/356]
[do_try_to_free_pages+98/128] [tvecs+7343/50008] [kswapd+126/300]
[kernel_thread+40/56] 
Oct 29 12:25:11 cs865114-a kernel: Code: 89 02 89 73 f8 89 73 fc 8b 45
f8 89 58 04 89 03 8d 45 f8 89 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   89 73 f8                  mov    %esi,0xfffffff8(%ebx)
Code;  00000005 Before first symbol
   5:   89 73 fc                  mov    %esi,0xfffffffc(%ebx)
Code;  00000008 Before first symbol
   8:   8b 45 f8                  mov    0xfffffff8(%ebp),%eax
Code;  0000000b Before first symbol
   b:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  0000000e Before first symbol
   e:   89 03                     mov    %eax,(%ebx)
Code;  00000010 Before first symbol
  10:   8d 45 f8                  lea    0xfffffff8(%ebp),%eax
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

==========================================================================================




Hardware:

Motherboard: Assus P2B
CPU: PIII-450
256MB RAM
13MB HDD ( WDC AC313000R ATA - primary master)
EIDE-ATAPI CDROM (MATSHITA CR-589 - primary slave)
ATAPI CDRW ( MITSBICDRW4420a - secondary master)
FDD

2 network cards
    eepro100 (eth0)
    3c590 (eth1)
sound card (ensoniq es1370)

============================================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
