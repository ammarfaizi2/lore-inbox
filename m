Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132715AbRDIKfY>; Mon, 9 Apr 2001 06:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132716AbRDIKfP>; Mon, 9 Apr 2001 06:35:15 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20234 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132715AbRDIKfE>; Mon, 9 Apr 2001 06:35:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: linux-kernel@vger.kernel.org
Subject: Oops on shutdown with 2.4.3
Date: Mon, 9 Apr 2001 12:33:37 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040912333700.00888@wintermute>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I received the following Oops several times since upgrading to 2.4.3. The 
Oops always occurs on shutdown, after the machine was under some meory 
pressure (128 Megs RAM, 256 Megs Swap, 131MB File mmapped for linear reading, 
another 100MB in khexedit, and some 30-40MB of data in memory in a file 
conversion utility.) While working the machine bahves as expected (runs 
smooth, swapping on changing apps and so on), but when shutting down the Oops 
occurs.

Unfortunately a debian upgrade removed the -x switch from my klogd, so all I 
have is the decoded Oops out of klogd. I am now "waiting" for the Oops to 
happen again, so I can run it through ksymoops, but AFAICT the output of 
klogd looks OK.

The machine is an Athlon 600 on an Asus K7M Board. If needed I can provide 
more info. I would be willing to try out patches and/or help debugging as far 
as I can (not a kernel hacker...).

Apr  7 17:58:29 wintermute kernel: Unable to handle kernel paging request at 
virtual address 082ae70c
Apr  7 17:58:29 wintermute kernel:  printing eip:
Apr  7 17:58:29 wintermute kernel: c0111233
Apr  7 17:58:29 wintermute kernel: *pde = 0181b067
Apr  7 17:58:29 wintermute kernel: *pte = 00000000
Apr  7 17:58:29 wintermute kernel: Oops: 0000
Apr  7 17:58:29 wintermute kernel: CPU:    0
Apr  7 17:58:29 wintermute kernel: EIP:    0010:[__wake_up+51/176]
Apr  7 17:58:29 wintermute kernel: EFLAGS: 00010017
Apr  7 17:58:29 wintermute kernel: eax: c1425ed0   ebx: 082ae710   ecx: 
00000001   edx: c1425ed4
Apr  7 17:58:29 wintermute kernel: esi: c1425e40   edi: 082ae708   ebp: 
c33b5eb4   esp: c33b5e98
Apr  7 17:58:29 wintermute kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 17:58:29 wintermute kernel: Process find (pid: 4021, 
stackpage=c33b5000)
Apr  7 17:58:29 wintermute kernel: Stack: 00000000 c1425e40 c7fe8160 c1425ed4 
00000001 00000282 00000003 c1256600
Apr  7 17:58:29 wintermute kernel:        c014099c 00000000 c7fe8160 00038254 
c1256600 c0140bb6 c1256600 00038254
Apr  7 17:58:29 wintermute kernel:        c7fe8160 00000000 00000000 00038254 
c53d5b40 c1233c40 c12323c0 c014e58b
Apr  7 17:58:29 wintermute kernel: Call Trace: [get_new_inode+236/352] 
[iget4+182/208] [ext2_lookup+91/144] [real_lookup+83/192] 
[path_walk+1401/2000] [getname+90/160] [__user_walk+60/96]
Apr  7 17:58:29 wintermute kernel:        [sys_lstat64+22/112] 
[system_call+51/56]
Apr  7 17:58:29 wintermute kernel:
Apr  7 17:58:29 wintermute kernel: Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 
31 c0 9c 5e fa c7 01 00

-- 
Patrick Dreker
---------------------------------------------------------------------
> Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.        
                         Alan Cox on linux-kernel@vger.kernel.org
