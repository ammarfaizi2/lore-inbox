Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268784AbRG0PYs>; Fri, 27 Jul 2001 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbRG0PYi>; Fri, 27 Jul 2001 11:24:38 -0400
Received: from abba.synaptique.co.uk ([213.86.145.226]:36472 "HELO
	host.domain.name") by vger.kernel.org with SMTP id <S267643AbRG0PYW>;
	Fri, 27 Jul 2001 11:24:22 -0400
Date: Fri, 27 Jul 2001 16:24:23 +0100
From: Samuel Dupas <samuel@dupas.com>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request at virtual address 3b617b05 ( was Re: swap_free: swap-space map bad (entry 00000100) )
Message-Id: <20010727162423.2fb6fc80.samuel@dupas.com>
In-Reply-To: <20010727111313.1da63aca.samuel@dupas.com>
In-Reply-To: <20010727111313.1da63aca.samuel@dupas.com>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi again,

I change the kernel (now 2.2.19) and I still have the same problem. It
begin by a "Unable to handle kernel paging request at virtual address"

And it strange, the machine rebooted by itself.
And after the reboot, the second disk was rebuilding (the machine is in
RAID mirroring)

Do you have an idea of the problem ?

Help would be very nice (The server is remote and I can't change hardware
easily, that's why before replacing the server I want to know what could
explain my problem)

Thanks
/var/log/messages
----------------------------------------------------------
Jul 27 15:50:20 euro kernel: Unable to handle kernel paging request at
virtual address 3b617b05 
Jul 27 15:50:20 euro kernel: current->tss.cr3 = 10d4a000, %%cr3 = 10d4a000

Jul 27 15:50:20 euro kernel: *pde = 00000000 
Jul 27 15:50:20 euro kernel: Oops: 0000 
Jul 27 15:50:20 euro kernel: CPU:    0 
Jul 27 15:50:20 euro kernel: EIP:    0010:[free_wait+62/120] 
Jul 27 15:50:20 euro kernel: EFLAGS: 00010007 
Jul 27 15:50:20 euro kernel: eax: 3b617b01   ebx: c64de280   ecx: ccef5d48
  edx: 3b617b01 
Jul 27 15:50:20 euro kernel: esi: c64de000   edi: c64de280   ebp: 00000207
  esp: d1fd5eec 
Jul 27 15:50:20 euro kernel: ds: 0018   es: 0018   ss: 0018 
Jul 27 15:50:20 euro kernel: Process ab (pid: 3800, process nr: 348,
stackpage=d1fd5000) 
Jul 27 15:50:20 euro kernel: Stack: 00100000 00000035 00000080 00000000
00000000 c012ec23 c64de000 00000000  
Jul 27 15:50:20 euro kernel:        00000035 c012ebf4 00000020 00000080
d4f9fb00 00000000 d20d13c0 d1fd4000  
Jul 27 15:50:20 euro kernel:        fffffff7 d1fd4000 d1fd4000 00000bac
00000000 c64de000 08050960 0000004e  
Jul 27 15:50:20 euro kernel: Call Trace: [do_select+487/512]
[do_select+440/512] [sys_select+881/1176] [net_bh+398/488]
[common_interrupt+24/32] [syst
em_call+52/56]  
Jul 27 15:50:20 euro kernel: Code: 8b 42 04 39 f8 75 f7 89 4a 04 55 9d 83
c4 f4 8b 43 fc 50 e8  
Jul 27 15:57:07 euro kernel: klogd 1.3-3, log source = /proc/kmsg started.
------------------------------------------------------------

Samuel
