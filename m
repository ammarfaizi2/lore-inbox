Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDQKD>; Sat, 4 Nov 2000 11:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDQJx>; Sat, 4 Nov 2000 11:09:53 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:61685 "EHLO ylenurme.ee")
	by vger.kernel.org with ESMTP id <S129057AbQKDQJo>;
	Sat, 4 Nov 2000 11:09:44 -0500
Date: Sat, 4 Nov 2000 18:09:23 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.0-test10 3c509,isapnp,SMP
Message-ID: <Pine.LNX.4.10.10011041807150.30056-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At mandrake bootup, both isapnp and 3c509 as modules

Nov  4 20:29:46 news kernel: isapnp: Scanning for Pnp cards... 
Nov  4 20:29:46 news kernel: isapnp: No Plug & Play device found 
Nov  4 20:29:46 news kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000070 
Nov  4 20:29:46 news kernel:  printing eip: 
Nov  4 20:29:46 news kernel: c89c25a5 
Nov  4 20:29:46 news kernel: *pde = 00000000 
Nov  4 20:29:46 news kernel: Oops: 0002 
Nov  4 20:29:46 news kernel: CPU:    0 
Nov  4 20:29:46 news kernel: EIP:    0010:[3c509:el3_probe+1349/4832] 
Nov  4 20:29:46 news kernel: EFLAGS: 00010202 
Nov  4 20:29:47 news kernel: eax: bfaf2000   ebx: 00000004   ecx: 00000070   edx: 00000070 
Nov  4 20:29:47 news kernel: esi: 00000000   edi: 00000000   ebp: 00000200   esp: c6b19f08 
Nov  4 20:29:47 news kernel: ds: 0018   es: 0018   ss: 0018 
Nov  4 20:29:47 news kernel: Process modprobe (pid: 305, stackpage=c6b19000) 
Nov  4 20:29:47 news kernel: Stack: 00000000 00000000 c89c204e ffffffea 00000070 c6b19f3c c6b19f2c 00000003  
Nov  4 20:29:47 news PAM_pwdb[398]: (su) session opened for user xfs by (uid=0)
Nov  4 20:29:47 news kernel:        51ff0001 c89c204e ffffffea c1044010 c0238cdc bfaf2000 ffff5c5c c89c3295  
Nov  4 20:29:47 news kernel:        00000000 c89c2000 00000001 c0119c18 c6b18000 0804b21b 080806e8 bfffe100  
Nov  4 20:29:47 news kernel: Call Trace: [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+78/96] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+78/96] [3c509:el3_probe+4661/4832] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+0/96] [sys_init_module+1016/1184] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+72/96] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+-32768/96]  
Nov  4 20:29:47 news kernel:        [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+72/96] [system_call+51/56] [call_spurious_interrupt+28439/33124]  
Nov  4 20:29:47 news kernel: Code: 89 02 8b 44 24 38 66 89 42 04 8b 4c 24 40 89 69 20 8b 44 24  
Nov  4 20:29:47 news kernel: usb.c: registered new driver usbdevfs 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
