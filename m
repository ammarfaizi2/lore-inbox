Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSAXNMH>; Thu, 24 Jan 2002 08:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSAXNL6>; Thu, 24 Jan 2002 08:11:58 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:40922 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287770AbSAXNLp>; Thu, 24 Jan 2002 08:11:45 -0500
Message-Id: <5.1.0.14.2.20020124130949.02614370@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Jan 2002 13:14:07 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: 2.5.3-pre4 panics on boot )-:
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops is below...

Can't attach .config nor decode oops at the moment as the machine is now 
dead (I am remote), I can reboot it remotely but LILO doesn't accept my 
remote commands (even though I send a break signal it doesn't do anything, 
just sits at prompt and after time out boots into -pre4 and dies - any 
ideas?). )-:

Is there a patch I can apply to fix this panic? Assuming one of the 
scheduler ones. But which one?

Best regards,

Anton

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1336.3655 MHz.
..... host bus clock speed is 267.2731 MHz.
cpu: 0, clocks: 2672731, slice: 1336365
CPU0<T0:2672720,T1:1336352,D:3,S:1336365,C:2672731>
kernel BUG at sched.c:588!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116d12>]    Not tainted
EFLAGS: 00010082
eax: 0000001b   ebx: c0386000   ecx: 00000001   edx: 00000c38
esi: c03c7cc0   edi: c0386000   ebp: c0387f84   esp: c0387f58
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0387000)
Stack: c02c9739 0000024c c0387f8c c0387fc0 c0105000 0008e000 c0107521 c0386000
        c0386000 c0387fc0 c0105000 0008e000 c0108ad9 00010f00 c0105050 00000000
        c0387fc0 c0105000 0008e000 00000001 00000018 00000018 00000078 c010711d
Call Trace: [<c0105000>] [<c0107521>] [<c0105000>] [<c0108ad9>] [<c0105050>]
    [<c0105000>] [<c010711d>] [<c0105019>] [<c0105050>]

Code: 0f 0b 58 5a fa f0 fe 0e 0f 88 60 f5 19 00 8b 4d f0 8b 01 85
  spurious 8259A interrupt: IRQ7.
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing



-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

