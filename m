Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAOHCr>; Mon, 15 Jan 2001 02:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRAOHCg>; Mon, 15 Jan 2001 02:02:36 -0500
Received: from [205.244.242.21] ([205.244.242.21]:57612 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S129830AbRAOHC1>;
	Mon, 15 Jan 2001 02:02:27 -0500
Message-Id: <200101150657.f0F6uDS21937@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2001 01:56:13 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan 15 00:09:55 news kernel: kernel BUG at inode.c:372!
Jan 15 00:09:55 news kernel: invalid operand: 0000
Jan 15 00:09:55 news kernel: CPU:    0
Jan 15 00:09:55 news kernel: EIP:    0010:[clear_inode+51/228]
Jan 15 00:09:55 news kernel: EFLAGS: 00010286
Jan 15 00:09:55 news kernel: eax: 0000001b   ebx: cb884b80   ecx: 00000000   edx: ffffffff
Jan 15 00:09:55 news kernel: esi: 00000044   edi: c47ed7c0   ebp: cb884b80   esp: cacf9eec
Jan 15 00:09:55 news kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 00:09:55 news kernel: Process expire (pid: 4292, stackpage=cacf9000)
Jan 15 00:09:55 news kernel: Stack: c021ff8c c022002c 00000174 cffca600 c014bb77 cb884b80 cb884b80 c026f080 
Jan 15 00:09:55 news kernel:        c47ed7c0 ccfe8460 cc0eb400 cc3ecde0 00000043 00000000 00000000 c6589de0 
Jan 15 00:09:55 news kernel:        c014c2a6 c014c2cc cb884b80 cb884b80 c0140f3f cb884b80 c47ed7c0 cb884b80 
Jan 15 00:09:55 news kernel: Call Trace: [tvecs+23744/48412] [tvecs+23904/48412] [ext2_free_inode+167/388] [ext2_delete_inode+102/156] [ext2_delete_inode+140/156] [iput+167/340] [dput+238/324] 
Jan 15 00:09:55 news kernel:        [sys_rename+434/568] [system_call+51/64] 
Jan 15 00:09:55 news kernel: Code: 0f 0b 83 c4 0c 8b 83 ec 00 00 00 a8 10 75 26 68 76 01 00 00 


I'm gonna hazard a guess that this hasn't changed much between prerelease and
-final, but I'll upgrade and see what happens.

This is using large file support (but I don't think it was a large file being renamed)

--Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
