Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRBLVpz>; Mon, 12 Feb 2001 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbRBLVpo>; Mon, 12 Feb 2001 16:45:44 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:35589 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S130067AbRBLVpg>; Mon, 12 Feb 2001 16:45:36 -0500
Date: Mon, 12 Feb 2001 15:45:26 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: linux-kernel@vger.kernel.org
Subject: OOPs in 2.4.1 SMP
Message-ID: <20010212154526.A29709@ganymede.isdn.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this oops on my HP Kayak XU dual Pentium II 300MHz. I added the
stuff right before it, though it may have nothing to do with the actual
Oops. My box is stull running, BTW :).

Feb 12 16:00:00 dangermouse CROND[11154]: (root) CMD (   /sbin/rmmod -as) 
Feb 12 16:00:00 dangermouse CROND[11155]: (wendling) CMD (cd
/home/wendling/setiathome ; if [ -z `/sbin/pidof setiathome` ]; then
/home/wendling/setiathome/setiathome -nice 19 -graphics ; fi) 
Feb 12 16:01:00 dangermouse CROND[11159]: (root) CMD (run-parts
/etc/cron.hourly) 
Feb 12 16:03:16 dangermouse kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Feb 12 16:03:16 dangermouse kernel:  printing eip:
Feb 12 16:03:16 dangermouse kernel: c885eac3
Feb 12 16:03:16 dangermouse kernel: *pde = 00000000
Feb 12 16:03:16 dangermouse kernel: Oops: 0000
Feb 12 16:03:16 dangermouse kernel: CPU:    1
Feb 12 16:03:17 dangermouse kernel: EIP:    0010:[<c885eac3>]
Feb 12 16:03:17 dangermouse kernel: EFLAGS: 00210292
Feb 12 16:03:17 dangermouse kernel: eax: 00000000   ebx: c05baa60   ecx:
c2b01060   edx: 00000000
Feb 12 16:03:17 dangermouse kernel: esi: c2b01060   edi: c5816c60   ebp:
0000004d   esp: c2e1ff44
Feb 12 16:03:17 dangermouse kernel: ds: 0018   es: 0018   ss: 0018
Feb 12 16:03:17 dangermouse kernel: Process cvs (pid: 11161,
stackpage=c2e1f000)
Feb 12 16:03:17 dangermouse kernel: Stack: 0000004d c2b01060 c885ecfd
c2b01060 08105875 00000000 c5816c80 000001b6 
Feb 12 16:03:17 dangermouse kernel:        081057c0 c724b000 c5816c60
ffffffea 00000000 0000004d c0134d06 c5816c60 
Feb 12 16:03:17 dangermouse kernel:        08105828 0000004d c5816c80
c0134930 00000002 c2e1e000 0027cd82 00000000 
Feb 12 16:03:17 dangermouse kernel: Call Trace: [<c885ecfd>]
[sys_write+150/208] [default_llseek+0/128] [sys_lseek+196/208]
[system_call+51/56] 
Feb 12 16:03:17 dangermouse kernel: 
Feb 12 16:03:17 dangermouse kernel: Code: 8b 70 08 8b 46 3c 8b 56 40 89
41 3c 0f ac d0 09 89 41 54 8b 


-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
