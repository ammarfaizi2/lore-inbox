Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTFBJHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTFBJHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:07:19 -0400
Received: from pan.togami.com ([66.139.75.105]:13210 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S262013AbTFBJHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:07:18 -0400
Subject: 2.5.70 kernel BUG include/linux/dcache.h:271!
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1054545600.2020.602.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 01 Jun 2003 23:20:00 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
Sony Vaio FXA36 Athlon laptop
Red Hat Linux Rawhide 

After 5 days of uptime on 2.5.70, I noticed this in my dmesg.  I don't
know what I was doing at the time when this happened.  Known bug?  Let
me know if you want more information about my hardware/software setup.

Please CC me in reply, I am not subscribed to lkml.

Thanks,
Warren Togami
warren@togami.com

------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:271!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c016ed76>]    Not tainted
EFLAGS: 00010246
EIP is at set_fs_pwd+0x36/0x90
eax: 00000000   ebx: dfd19de0   ecx: c07be600   edx: dfff28c0
esi: dfff28c0   edi: cbd20ec0   ebp: dfff28c0   esp: c9395f90
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 18515, threadinfo=c9394000 task=cec24cc0)
Stack: c07be600 d0c68ac0 00000000 c07be600 c0150686 dfd19de0 dfff28c0
c07be600
       00000005 00058f78 00000000 c9394000 c01092a5 00000005 00000000
00fb1a14
       00058f78 00000000 bffffc28 00000085 0000007b 0000007b 00000085
ffffe410
Call Trace:
 [<c0150686>] sys_fchdir+0x96/0xa0
 [<c01092a5>] sysenter_past_esp+0x52/0x71
 
Code: 0f 0b 0f 01 fb e0 30 c0 ff 01 89 4b 0c b8 00 e0 ff ff 21 e0
 <6>note: updatedb[18515] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c01197e7>] schedule+0x397/0x3a0
 [<c0142b43>] unmap_page_range+0x43/0x70
 [<c0142d30>] unmap_vmas+0x1c0/0x220
 [<c0146bdb>] exit_mmap+0x7b/0x190
 [<c011b144>] mmput+0x54/0xb0
 [<c011ee59>] do_exit+0x119/0x400
 [<c0109e70>] do_invalid_op+0x0/0xd0
 [<c0109af1>] die+0xe1/0xf0
 [<c0109f39>] do_invalid_op+0xc9/0xd0
 [<c016ed76>] set_fs_pwd+0x36/0x90
 [<c015b905>] cp_new_stat64+0x105/0x110
 [<c01094a1>] error_code+0x2d/0x38
 [<c016ed76>] set_fs_pwd+0x36/0x90
 [<c0150686>] sys_fchdir+0x96/0xa0
 [<c01092a5>] sysenter_past_esp+0x52/0x71


