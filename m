Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVKTW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVKTW1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVKTW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:27:11 -0500
Received: from smtp010.tiscali.dk ([212.54.64.103]:9712 "EHLO
	smtp010.tiscali.dk") by vger.kernel.org with ESMTP id S932094AbVKTW1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:27:10 -0500
From: Zorglub <zorglub_olsen@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.6.14
Date: Sun, 20 Nov 2005 23:26:16 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202326.16222.zorglub_olsen@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

my machine suddenly froze. It's been working just fine for about a week or so. 
No unusual load. I read in Documentation/oops-tracing.txt that I should 
probably send the log (var/log/messages) to this list. So here goes:

Nov 20 23:07:52 asimov Unable to handle kernel NULL pointer dereference at 
virtual address 00000008
Nov 20 23:07:52 asimov printing eip:
Nov 20 23:07:52 asimov c0114096
Nov 20 23:07:52 asimov *pde = 00000000
Nov 20 23:07:52 asimov Oops: 0000 [#1]
Nov 20 23:07:52 asimov PREEMPT
Nov 20 23:07:52 asimov Modules linked in: nvidia
Nov 20 23:07:52 asimov CPU:    0
Nov 20 23:07:52 asimov EIP:    0060:[<c0114096>]    Tainted: P      VLI
Nov 20 23:07:52 asimov EFLAGS: 00010282   (2.6.14-gentoo-r2)
Nov 20 23:07:52 asimov EIP is at copy_mm+0x226/0x3f0
Nov 20 23:07:52 asimov eax: 00000000   ebx: cdca1bcc   ecx: df549040   edx: 
dc5c88e0
Nov 20 23:07:52 asimov esi: d50b343c   edi: cdca1c24   ebp: d50b33e4   esp: 
dbae9ec8
Nov 20 23:07:52 asimov ds: 007b   es: 007b   ss: 0068
Nov 20 23:07:52 asimov Process sh (pid: 12595, threadinfo=dbae8000 
task=d60ea580)
Nov 20 23:07:52 asimov Stack: cdca1bcc 000000d0 cdca15f4 cdca1244 dbae8000 
df93b4f0 cdca160c cdca1614
Nov 20 23:07:52 asimov cdca1600 df93b4c0 df549040 c751b5e0 c835f878 00000000 
01200011 c0114be4
Nov 20 23:07:52 asimov 01200011 c751b5e0 00000500 00000000 df93b4c0 00000001 
df7b30c0 dbae8000
Nov 20 23:07:52 asimov Call Trace:
Nov 20 23:07:52 asimov [<c0114be4>] copy_process+0x424/0xd80
Nov 20 23:07:52 asimov [<c0115649>] do_fork+0x69/0x182
Nov 20 23:07:52 asimov [<c0209512>] copy_to_user+0x42/0x60
Nov 20 23:07:52 asimov [<c0122900>] sys_rt_sigprocmask+0xa0/0x100
Nov 20 23:07:52 asimov [<c01019de>] sys_clone+0x3e/0x50
Nov 20 23:07:52 asimov [<c0102e27>] sysenter_past_esp+0x54/0x75
Nov 20 23:07:52 asimov Code: 00 89 ee f3 a5 81 60 14 ff df ff ff 8b 4c 24 28 
c7 40 0c 00 00 00 00 89 08 89 04 24 e8 04 63 03 00 8b 53 4c 85 d2 74 40 8b 42 
08
 <8b> 40 08 ff 42 14 f6 43 15 08 74 06 ff 88 30 01 00 00 8b 44 24
