Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262540AbSJBSae>; Wed, 2 Oct 2002 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbSJBSae>; Wed, 2 Oct 2002 14:30:34 -0400
Received: from pegasus.mail.eclipse.net.uk ([212.104.129.225]:53783 "HELO
	pegasus.mail.eclipse.net.uk") by vger.kernel.org with SMTP
	id <S262540AbSJBSac>; Wed, 2 Oct 2002 14:30:32 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Peter L Jones <peter@drealm.org.uk>
Organization: The Dwarfen Realm
Subject: kernel BUG at slab.c:1292
Date: Wed, 2 Oct 2002 19:35:51 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Message-Id: <200210021935.51996@advent.drealm.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I asked on #kernelnewbies what I should do with this and was told to check the 
mailing list archive at http://marc.theaimsgroup.com/ - which I've done.

The following was produced during boot.  I _looks_ like it was during a 
modprobe, but I'm not entirely sure what - it could be that binfmt_misc but I 
couldn't find any docs in the tree for BUG() tracebacks (and I probably 
wouldn't have understood the source).

I'm not subscribed to the list: if anyone wants more info, drop me private 
mail and I'll see what I can do.

Hope this helps,

Thanks,

-- Peter


Oct  2 16:59:40 advent kernel: ------------[ cut here ]------------
Oct  2 16:59:40 advent kernel: kernel BUG at slab.c:1292!
Oct  2 16:59:40 advent kernel: invalid operand: 0000
Oct  2 16:59:40 advent kernel: vfat fat binfmt_misc
Oct  2 16:59:40 advent kernel: CPU:    0
Oct  2 16:59:40 advent kernel: EIP:    0060:[kmem_cache_alloc+346/464]    Not 
tainted
Oct  2 16:59:40 advent kernel: EFLAGS: 00010012
Oct  2 16:59:40 advent kernel: EIP is at kmem_cache_alloc+0x15a/0x1d0
Oct  2 16:59:40 advent kernel: eax: ca342fff   ebx: ca342000   ecx: 00000001   
edx: 00000001
Oct  2 16:59:40 advent kernel: esi: c11af390   edi: 00000000   ebp: 00012800   
esp: ca139f18
Oct  2 16:59:40 advent kernel: ds: 0068   es: 0068   ss: 0068
Oct  2 16:59:40 advent kernel: Process mount (pid: 72, threadinfo=ca138000 
task=ca695900)
Oct  2 16:59:40 advent kernel: Stack: c024dc00 fffffff4 ca7ff39c ca139f5c 
00001000 00000000 00000246 c013dfcc
Oct  2 16:59:40 advent kernel:        c11af390 000001d0 ca138000 ffffffff 
ca7ff39c c0105a6e c024dc00 ca138000
Oct  2 16:59:40 advent kernel:        ffffffff ca695900 c0106dc3 c024dc00 
ca139fd8 c024dd00 ffffffff ca7ff39c
Oct  2 16:59:40 advent kernel: Call Trace:
Oct  2 16:59:40 advent kernel:  [getname+28/156]getname+0x1c/0x9c
Oct  2 16:59:40 advent kernel:  [sys_execve+14/96]sys_execve+0xe/0x60
Oct  2 16:59:40 advent kernel:  [syscall_call+7/11]syscall_call+0x7/0xb
Oct  2 16:59:40 advent kernel:  
[exec_usermodehelper+859/904]exec_usermodehelper+0x35b/0x388
Oct  2 16:59:40 advent kernel:  [exec_modprobe+0/164]exec_modprobe+0x0/0xa4
Oct  2 16:59:40 advent kernel:  [exec_modprobe+92/164]exec_modprobe+0x5c/0xa4
Oct  2 16:59:40 advent kernel:  [exec_modprobe+0/164]exec_modprobe+0x0/0xa4
Oct  2 16:59:40 advent kernel:  
[kernel_thread_helper+5/12]kernel_thread_helper+0x5/0xc
Oct  2 16:59:40 advent kernel:
Oct  2 16:59:40 advent kernel: Code: 0f 0b 0c 05 b3 9a 20 c0 f7 c5 00 04 00 00 
74 36 b8 a5 c2 0f

