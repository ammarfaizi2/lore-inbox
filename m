Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSHZPJC>; Mon, 26 Aug 2002 11:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSHZPJC>; Mon, 26 Aug 2002 11:09:02 -0400
Received: from mail.aliacom.fr ([213.41.82.82]:5893 "EHLO mail.aliacom.fr")
	by vger.kernel.org with ESMTP id <S315260AbSHZPJA>;
	Mon, 26 Aug 2002 11:09:00 -0400
Message-ID: <3D6A5FE8.3090204@aliacom.fr>
Date: Mon, 26 Aug 2002 19:05:44 +0200
From: Thomas Cataldo <thomas.cataldo@aliacom.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops in prune_dcache on linux-2.4.20-pre2-ac5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

If this problem is already solved in recent -ac kernels, please ignore.


Aug 26 18:53:23 chienne kernel: Unable to handle kernel paging request 
at virtual address 08084000
Aug 26 18:53:24 chienne kernel:  printing eip:
Aug 26 18:53:24 chienne kernel: c0140258
Aug 26 18:53:24 chienne kernel: *pde = 00000000
Aug 26 18:53:24 chienne kernel: Oops: 0002
Aug 26 18:53:24 chienne kernel: CPU:    0
Aug 26 18:53:24 chienne kernel: EIP:    0010:[prune_dcache+24/312] 
Not tainted
Aug 26 18:53:24 chienne kernel: EFLAGS: 00010206
Aug 26 18:53:24 chienne kernel: eax: c0265460   ebx: cf4b8818   ecx: 
cf4b8000   edx: 08084000
Aug 26 18:53:24 chienne kernel: esi: cf4b8e00   edi: ca2b6280   ebp: 
00000308   esp: c1367fa0
Aug 26 18:53:24 chienne kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 18:53:24 chienne kernel: Process kswapd (pid: 4, stackpage=c1367000)
Aug 26 18:53:24 chienne kernel: Stack: 000001d0 00000078 00000000 
0008e000 c01405cb 0000096b c0128e5f 00000006
Aug 26 18:53:24 chienne kernel:        000001d0 000001d0 c0264720 
00000064 00000000 c0129114 000001d0 00010f00
Aug 26 18:53:24 chienne kernel:        c1349fb8 00000000 0008e000 
c0105517 c0105520 00000000 00000078 c0277fd8
Aug 26 18:53:24 chienne kernel: Call Trace: 
[shrink_dcache_memory+27/52] [do_try_to_free_pages+23/368] 
[kswapd+240/684] [kernel_thread+31/56] [kernel_thread+40/56]


Here is the lspci output:
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset 
Graphics Controller] (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 11)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 11)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 11)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 11)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 11)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 11)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 11)
01:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 74)
01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet 
Controller (rev 03)

