Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRJZCQr>; Thu, 25 Oct 2001 22:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277317AbRJZCQh>; Thu, 25 Oct 2001 22:16:37 -0400
Received: from peabody.ximian.com ([141.154.95.10]:21267 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S277316AbRJZCQX>; Thu, 25 Oct 2001 22:16:23 -0400
Subject: Seg fault when syncing Sony Clie 760 with USB cradle
From: "Peter A. Goodall" <pete@ximian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.24.21.44 (Preview Release)
Date: 25 Oct 2001 22:16:59 -0400
Message-Id: <1004062619.1406.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Redhat 7.1 with the 2.4.12 kernel and using xfs.  I have
applied an SGI patch (linux-2.4.12-xfs-2001-10-11.patch.bz2) to run
xfs.  I am using coldsync 2.2.0 to sync and everytime I try to sync it I
get a seg fault.  This causes a kernel panic and I am no longer able to
use the USB port until I reboot.  Below is the end of /var/log/messages:

Oct 25 20:23:10 localhost kernel: usb_control/bulk_msg: timeout 
Oct 25 20:23:10 localhost kernel: visor.c: visor_startup - error getting
first unknown palm command 
Oct 25 20:23:13 localhost kernel: usb_control/bulk_msg: timeout 
Oct 25 20:23:13 localhost kernel: visor.c: visor_startup - error getting
second unknown palm command 
Oct 25 20:23:13 localhost kernel: usbserial.c: Sony Clie 4.0 converter
now attached to ttyUSB0 (or usb/tts/0 for devfs) 
Oct 25 20:23:13 localhost kernel: usbserial.c: Sony Clie 4.0 converter
now attached to ttyUSB1 (or usb/tts/1 for devfs) 
Oct 25 20:23:13 localhost kernel: visor.c: USB HandSpring Visor, Palm
m50x, Sony Clie driver v1.4 
Oct 25 20:23:15 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000014 
Oct 25 20:23:15 localhost kernel:  printing eip: 
Oct 25 20:23:15 localhost kernel: c88c6103 
Oct 25 20:23:15 localhost kernel: *pde = 00000000 
Oct 25 20:23:15 localhost kernel: Oops: 0002 
Oct 25 20:23:15 localhost kernel: CPU:    0 
Oct 25 20:23:15 localhost kernel: EIP:   
0010:[fat:__insmod_fat_S.bss_L2264+389699/11025069]    Not tainted 
Oct 25 20:23:15 localhost kernel: EIP:    0010:[<c88c6103>]    Not
tainted 
Oct 25 20:23:15 localhost kernel: EFLAGS: 00013202 
Oct 25 20:23:15 localhost kernel: eax: c3c69800   ebx: c71ef494   ecx:
c71ef4f0   edx: 00000000 
Oct 25 20:23:15 localhost kernel: esi: c71ef400   edi: 00000000   ebp:
c2f01edc   esp: c2f01ea4 
Oct 25 20:23:15 localhost kernel: ds: 0018   es: 0018   ss: 0018 
Oct 25 20:23:15 localhost kernel: Process coldsync (pid: 1055,
stackpage=c2f01000) 
Oct 25 20:23:15 localhost kernel: Stack: c2f30000 c50333c0 0000bc01
c88c03f4 c71ef494 c50333c0 c2f30000 00000000 
Oct 25 20:23:15 localhost kernel:        c01cf995 c2f30000 c50333c0
c019e29b c502018c 00000002 c2f30000 c01b579f 
Oct 25 20:23:15 localhost kernel:        c5020100 00000008 c5020100
00000180 00000000 c5020100 00000008 c2ec30a0 
Oct 25 20:23:15 localhost kernel: Call Trace:
[fat:__insmod_fat_S.bss_L2264+365876/11048892] [tty_open+565/960]
[xfs_iunlock+75/128] [xfs_access+47/64] [linvfs_permission+33/48] 
Oct 25 20:23:15 localhost kernel: Call Trace: [<c88c03f4>] [<c01cf995>]
[<c019e29b>] [<c01b579f>] [<c01c0051>] 
Oct 25 20:23:15 localhost kernel:    [permission+29/48]
[chrdev_open+54/64] [dentry_open+230/400] [filp_open+77/96]
[getname+94/160] [sys_open+52/144] 
Oct 25 20:23:15 localhost kernel:    [<c013bcbd>] [<c0133e26>]
[<c0132e76>] [<c0132d7d>] [<c013bb3e>] [<c01330a4>] 
Oct 25 20:23:15 localhost kernel:    [tracesys+31/35] 
Oct 25 20:23:15 localhost kernel:    [<c0106f77>] 
Oct 25 20:23:15 localhost kernel: 
Oct 25 20:23:15 localhost kernel: Code: 89 42 14 8b 4e 04 0f b6 53 24 8b
01 c1 e2 0f c1 e0 08 09 d0 
Oct 25 20:24:07 localhost kernel:  <6>usb.c: USB disconnect on device 2 

Please CC pete@ximian.com in the reply. 

- Pete 
-- 

