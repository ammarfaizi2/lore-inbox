Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbSJFURB>; Sun, 6 Oct 2002 16:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262179AbSJFURB>; Sun, 6 Oct 2002 16:17:01 -0400
Received: from bazooka.saturnus.vein.hu ([193.6.40.77]:22668 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S262162AbSJFURA>; Sun, 6 Oct 2002 16:17:00 -0400
Date: Sun, 6 Oct 2002 22:22:36 +0200
To: linux-kernel@vger.kernel.org
Subject: BUG: loading module analog.o with emu10k1-gp
Message-ID: <20021006202236.GA836@bazooka.saturnus.vein.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Banai Zoltan <bazooka@vekoll.vein.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

I get the following error while trying to load analog joystick driver.

kernel: gameport: Creative Labs SB Live! MIDI/Game Port at pci02:0b.1 speed 917 kHz
kernel: register interface 'joystick' with class 'input
kernel: Unable to handle kernel paging request at virtual address fffffff0
kernel:  printing eip:
kernel: c0272e83
kernel: *pde = 00001063
kernel: *pte = 00000000
kernel: Oops: 0000
kernel: analog joydev emu10k1-gp gameport ppp_generic slhc  
kernel: CPU:    0
kernel: EIP:    0060:[usb_dump_config_descriptor+47/84]    Not tainted
kernel: EFLAGS: 00210213
kernel: EIP is at input_event+0x353/0x380
kernel: eax: ceaf00d8   ebx: 00000000   ecx: 00000000   edx: ffffffec
kernel: esi: 00000348   edi: ceaf0644   ebp: ceaf001c   esp: cf3a1e64
kernel: ds: 0068   es: 0068   ss: 0068
kernel: Process modprobe (pid: 14060, threadinfo=cf3a0000 task=d7cb9180)
kernel: Stack: ceaf0e08 00000000 00000001 ceaf001c ceaf0428 00000000 ceaf00d8 e09cf25c 
kernel:        ceaf001c 00000003 00000000 00000348 00001000 ceaf001c ceaf0000 ceaf0e08 
kernel:        e09cff32 ceaf001c ceaf0df4 ceaf0e08 00000000 ceaf001c 00000000 ceaf0654 
kernel: Call Trace:
kernel:  [<e09cf25c>]analog_decode+0x1b8/0x25c [analog]
kernel:  [<e09cff32>]analog_init_device+0x39a/0x49c [analog]
kernel:  [<e09d061e>]analog_connect+0xb6/0xd4 [analog]
kernel:  [<e09d1100>]analog_dev+0x0/0x20 [analog]
kernel:  [<e08b0271>]gameport_register_device_R9d9e0914+0x35/0x44 [gameport]
kernel:  [<e09d1100>]analog_dev+0x0/0x20 [analog]
kernel:  [<e09d07c7>]init_module+0xf/0x18 [analog]
kernel:  [<e09d1100>]analog_dev+0x0/0x20 [analog]
kernel:  [sys_delete_module+161/636]sys_init_module+0x515/0x5ec
kernel:  [<e09cf060>]get_time_pit+0x0/0x44 [analog]
kernel:  [syscall_call+7/11]syscall_call+0x7/0xb
kernel: 
kernel: Code: 83 7b f0 00 74 17 8b 43 fc 56 8b 4c 24 2c 51 8b 4c 24 2c 51

Regards,
--
Banai Zoltan
