Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUIWKJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUIWKJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUIWKJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:09:13 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:21712 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268360AbUIWKJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:09:09 -0400
Date: Thu, 23 Sep 2004 12:09:06 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-ID: <20040923100906.GB11230@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sep 23 11:26:24 debian kernel: c030a94e
Sep 23 11:26:24 debian kernel: PREEMPT 
Sep 23 11:26:24 debian kernel: Modules linked in: wlan_wep yenta_socket pcmcia_core ath_pci ath_rate_onoe wlan a
th_hal i830 8139too ehci_hcd uhci_hcd rtc
Sep 23 11:26:24 debian kernel: CPU:    0
Sep 23 11:26:24 debian kernel: EIP:    0060:[fn_hash_insert+1039/1159]    Tainted:  P   VLI
Sep 23 11:26:24 debian kernel: EFLAGS: 00210206   (2.6.9-rc2-mm2) 
Sep 23 11:26:24 debian kernel: EIP is at fn_hash_insert+0x40f/0x487
Sep 23 11:26:24 debian kernel: eax: 00000000   ebx: ccd68388   ecx: 6036fb93   edx: 00000c01
Sep 23 11:26:24 debian kernel: esi: cdd19e5c   edi: cdfd6980   ebp: ccf418a0   esp: cdd19d90
Sep 23 11:26:24 debian kernel: ds: 007b   es: 007b   ss: 0068
Sep 23 11:26:24 debian kernel: Process ifconfig (pid: 1470, threadinfo=cdd18000 task=cbbe0cf0)
Sep 23 11:26:24 debian kernel: Stack: ccd68380 00000000 00000000 cdd19ddc 000000d0 415296c0 04590480 cc988310 
Sep 23 11:26:24 debian kernel:        00000000 6036fb93 0c0159e4 cc988310 6036fb93 0016f057 00000002 00000020 
Sep 23 11:26:24 debian kernel:        f0000017 ccd68380 00000000 ffffffef 6036fb93 cdd19e0c cdd19e5c cdd19e40 
Sep 23 11:26:24 debian kernel: Call Trace:
Sep 23 11:26:24 debian kernel:  [fib_magic+271/284] fib_magic+0x10f/0x11c
Sep 23 11:26:24 debian kernel:  [filemap_nopage+429/910] filemap_nopage+0x1ad/0x38e
Sep 23 11:26:24 debian kernel:  [fib_add_ifaddr+113/390] fib_add_ifaddr+0x71/0x186
Sep 23 11:26:24 debian kernel:  [fib_inetaddr_event+99/101] fib_inetaddr_event+0x63/0x65
Sep 23 11:26:24 debian kernel:  [notifier_call_chain+39/62] notifier_call_chain+0x27/0x3e
Sep 23 11:26:24 debian kernel:  [inet_insert_ifa+162/319] inet_insert_ifa+0xa2/0x13f
Sep 23 11:26:24 debian kernel:  [devinet_ioctl+867/1828] devinet_ioctl+0x363/0x724
Sep 23 11:26:24 debian kernel:  [inet_ioctl+94/158] inet_ioctl+0x5e/0x9e
Sep 23 11:26:24 debian kernel:  [sock_ioctl+255/679] sock_ioctl+0xff/0x2a7
Sep 23 11:26:24 debian kernel:  [sys_ioctl+249/598] sys_ioctl+0xf9/0x256
Sep 23 11:26:24 debian kernel:  [do_page_fault+0/1449] do_page_fault+0x0/0x5a9
Sep 23 11:26:24 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 23 11:26:24 debian kernel: Code: ce 89 5c 24 2c 8b 43 04 8b 18 8b 0b 89 4c 24 1c 0f 18 01 90 3b 5b 04 74 34 
8b 47 28 89 44 24 20 8b 4b 08 8b 44 24 20 89 4c 24 24 <39> 41 28 75 1d 0f b6 43 0d 3b 44 24 38 74 2a 8b 5c 24 1c
 8b 03

-- 
Luká¹ Hejtmánek
