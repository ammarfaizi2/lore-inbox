Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDYH4N>; Thu, 25 Apr 2002 03:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDYH4M>; Thu, 25 Apr 2002 03:56:12 -0400
Received: from WARSL401PIP2.highway.telekom.at ([195.3.96.74]:23902 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S312980AbSDYH4M>;
	Thu, 25 Apr 2002 03:56:12 -0400
Message-ID: <004601c1ec2e$a59e4bb0$fe78a8c0@robert>
From: "Robert Schelander" <rschelander@aon.at>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0204242313480.8788-100000@dragon.pdx.osdl.net>
Subject: swap_free: Bad swap offset entry
Date: Thu, 25 Apr 2002 09:35:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a 2.4.17 system with high filesystem load and experience the
following problem:

after running some hours with ext2 I got a lot of these messages:
Apr 24 22:19:00 linux kernel: swap_free: Bad swap offset entry 04000000

if I do a swapoff (swap is at /dev/hda6) they turn to:
Apr 24 22:20:29 linux kernel: swap_free: Unused swap file entry 04000000

..and get back to "Bad swap offset entry" if I do the swapon again


Before that I run the machine with ext3 where even worse things happened.
I got a lot of these messages before the machine hangs some hours later:

Apr 22 04:01:04 linux kernel: Unable to handle kernel paging request at
virtual address e71d6478
Apr 22 04:01:04 linux kernel:  printing eip:
Apr 22 04:01:04 linux kernel: c013ede8
Apr 22 04:01:04 linux kernel: *pde = 00000000
Apr 22 04:01:04 linux kernel: Oops: 0002
Apr 22 04:01:04 linux kernel: CPU:    0
Apr 22 04:01:04 linux kernel: EIP:    0010:[prune_dcache+24/296]    Not
tainted
Apr 22 04:01:04 linux kernel: EFLAGS: 00210212
Apr 22 04:01:04 linux kernel: eax: c027c93c   ebx: c71d63f8   ecx: c71d6040
edx: e71d6478
Apr 22 04:01:04 linux kernel: esi: c71d62e0   edi: 00000000   ebp: 00007e35
esp: c3771e04
Apr 22 04:01:04 linux kernel: ds: 0018   es: 0018   ss: 0018
Apr 22 04:01:04 linux kernel: Process mogrify (pid: 913, stackpage=c3771000)
Apr 22 04:01:04 linux kernel: Stack: 00000004 000001d2 00000020 00000006
c013f14b 0000a4d0 c01290e0 00000006
Apr 22 04:01:05 linux kernel:        000001d2 00000006 000001d2 c027bc48
c027bc48 c027bc48 c012913c 00000020
Apr 22 04:01:05 linux kernel:        c3770000 00000100 00000000 c0129942
c027bdc4 00000100 00000010 00000000
Apr 22 04:01:05 linux kernel: Call Trace: [shrink_dcache_memory+27/52]
[shrink_caches+108/140] [try_to_free_pages+60/92] [balance_classzone+78/360]
[__alloc_pages+262/356]
Apr 22 04:01:05 linux kernel:    [_alloc_pages+22/24]
[do_anonymous_page+52/228] [do_no_page+51/400] [handle_mm_fault+82/176]
[do_page_fault+352/1176] [do_page_fault+0/1176]
Apr 22 04:01:05 linux kernel:    [update_wall_time+11/52] [timer_bh+36/604]
[do_timer+63/108] [timer_interrupt+95/264] [bh_action+26/64]
[tasklet_hi_action+68/100]
Apr 22 04:01:05 linux kernel:    [do_softirq+90/164] [error_code+52/60]
Apr 22 04:01:05 linux kernel:
Apr 22 04:01:05 linux kernel: Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54
a8 08 74 27 24 f7 89


Any ideas/help??

Thanks in advance
Robert


