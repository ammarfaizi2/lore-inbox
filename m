Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbRG0Pl6>; Fri, 27 Jul 2001 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbRG0Pls>; Fri, 27 Jul 2001 11:41:48 -0400
Received: from pmesmtp02.wcom.com ([199.249.20.2]:16013 "EHLO
	pmesmtp02.wcom.com") by vger.kernel.org with ESMTP
	id <S268865AbRG0Pli>; Fri, 27 Jul 2001 11:41:38 -0400
Date: Fri, 27 Jul 2001 10:40:54 -0500
From: Sunny Zhou <sunny.zhou@wcom.com>
Subject: RE: Unable to handle kernel paging request at virtual address 3b617b05
 (was Re: swap_free: swap-space map bad (entry 00000100) )
In-Reply-To: <20010727162423.2fb6fc80.samuel@dupas.com>
To: "'Samuel Dupas'" <samuel@dupas.com>, linux-kernel@vger.kernel.org
Reply-to: sunny.zhou@wcom.com
Message-id: <021a01c116b2$867aa960$689723a6@rcc05221.mcit.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.2120.0
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Yesterday I got the same problem. I believe your hard disk is SCSI
interface, and you are using 2.4.x kernel, right?
I reduced my swapping space to 600MB and it worked(at least
yesterday).
Don't know why.

Sunny


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Samuel Dupas
Sent: Friday, July 27, 2001 10:24 AM
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request at virtual address
3b617b05 (was Re: swap_free: swap-space map bad (entry 00000100) )



Hi again,

I change the kernel (now 2.2.19) and I still have the same problem.
It
begin by a "Unable to handle kernel paging request at virtual
address"

And it strange, the machine rebooted by itself.
And after the reboot, the second disk was rebuilding (the machine is
in
RAID mirroring)

Do you have an idea of the problem ?

Help would be very nice (The server is remote and I can't change
hardware
easily, that's why before replacing the server I want to know what
could
explain my problem)

Thanks
/var/log/messages
----------------------------------------------------------
Jul 27 15:50:20 euro kernel: Unable to handle kernel paging request
at
virtual address 3b617b05
Jul 27 15:50:20 euro kernel: current->tss.cr3 = 10d4a000, %%cr3 =
10d4a000

Jul 27 15:50:20 euro kernel: *pde = 00000000
Jul 27 15:50:20 euro kernel: Oops: 0000
Jul 27 15:50:20 euro kernel: CPU:    0
Jul 27 15:50:20 euro kernel: EIP:    0010:[free_wait+62/120]
Jul 27 15:50:20 euro kernel: EFLAGS: 00010007
Jul 27 15:50:20 euro kernel: eax: 3b617b01   ebx: c64de280   ecx:
ccef5d48
  edx: 3b617b01
Jul 27 15:50:20 euro kernel: esi: c64de000   edi: c64de280   ebp:
00000207
  esp: d1fd5eec
Jul 27 15:50:20 euro kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 15:50:20 euro kernel: Process ab (pid: 3800, process nr: 348,
stackpage=d1fd5000)
Jul 27 15:50:20 euro kernel: Stack: 00100000 00000035 00000080
00000000
00000000 c012ec23 c64de000 00000000
Jul 27 15:50:20 euro kernel:        00000035 c012ebf4 00000020
00000080
d4f9fb00 00000000 d20d13c0 d1fd4000
Jul 27 15:50:20 euro kernel:        fffffff7 d1fd4000 d1fd4000
00000bac
00000000 c64de000 08050960 0000004e
Jul 27 15:50:20 euro kernel: Call Trace: [do_select+487/512]
[do_select+440/512] [sys_select+881/1176] [net_bh+398/488]
[common_interrupt+24/32] [syst
em_call+52/56]
Jul 27 15:50:20 euro kernel: Code: 8b 42 04 39 f8 75 f7 89 4a 04 55
9d 83
c4 f4 8b 43 fc 50 e8
Jul 27 15:57:07 euro kernel: klogd 1.3-3, log source = /proc/kmsg
started.
------------------------------------------------------------

Samuel
-
To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

