Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRLMApy>; Wed, 12 Dec 2001 19:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLMApp>; Wed, 12 Dec 2001 19:45:45 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:33418 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S282963AbRLMApd>; Wed, 12 Dec 2001 19:45:33 -0500
Date: Wed, 12 Dec 2001 16:40:33 -0800
To: linux-kernel@vger.kernel.org
Subject: Kernel oops on 2.2.14-xfs (1.0.2 release)
Message-ID: <20011212164033.U24626@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Delivery-Agent: TMDA v0.42/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1008636034.8da705@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 invalid operand: 0000
 CPU:    1
 EIP:    0010:[rmqueue+405/472]    Not tainted
 EFLAGS: 00010202
 eax: 00000848   ebx: c0301168   ecx: c0301150   edx: 000f9063
 esi: c4e418c0   edi: 00000000   ebp: 00000001   esp: f4473f04
 ds: 0018   es: 0018   ss: 0018
 Process exp (pid: 17154, stackpage=f4473000) 
 Stack: c030121c 00000001 c0301150 00000000 000c1063 00000286 00000000
c0301150
        c012dc1b 000001d2 00000247 fffffff4 f7896250 00000247 c0301150
c0301218
        000001d2 c0128a7c c012da62 00000000 c0128a9c f5a51c20 ffffffea
00000000
 Call Trace: [__alloc_pages+71/436] [generic_file_write+976/1484]
[_alloc_pages+22/24] [generic_file_write+1008/1484] [sys_write+143/196]
    [system_call+47/52]
 
 Code: 0f 0b 90 8d 74 26 00 8b 46 18 a8 80 74 02 0f 0b 8b 46 14 85
  invalid operand: 0000
 CPU:    1
 EIP:    0010:[__free_pages_ok+17/516]    Not tainted
 EFLAGS: 00010286
 eax: c4e418c0   ebx: c4e418c0   ecx: c4e418c0   edx: 00000000
 esi: f9063025   edi: 00000000   ebp: 0019b000   esp: f4473d34
 ds: 0018   es: 0018   ss: 0018
 Process exp (pid: 17154, stackpage=f4473000) 
 Stack: c4e418c0 f9063025 00000000 0019b000 c03010a8 c1040000 00000202
ffffffff
        c012c866 c012ddfc c4e418c0 c012e256 c4e418c0 c012276c c4e418c0
00000010
        00000097 c035dc80 c0122f35 f9063025 00000000 f65671e0 f6738300
40014000
 Call Trace: [lru_cache_del+18/28] [page_cache_release+52/56]
[free_page_and_swap_cache+50/52] [__free_pte+76/84]
[zap_page_range+1029/1088]
    [exit_mmap+196/276] [mmput+75/100] [do_exit+187/592]
[do_invalid_op+0/136] [die+99/100] [do_invalid_op+127/136]
    [rmqueue+405/472] [ext2_get_block+799/960] [ext2_get_block+209/960]
[error_code+52/60] [rmqueue+405/472] [__alloc_pages+71/436]
    [generic_file_write+976/1484] [_alloc_pages+22/24]
[generic_file_write+1008/1484] [sys_write+143/196] [system_call+47/52]
 
 Code: 0f 0b 8b 53 08 85 d2 74 02 0f 0b 89 d8 2b 05 cc 06 39 c0 c1

I replaced the kernel with stock 2.4.14 and get similar errors.

Please advise.

--Adam

-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
