Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbRE0ABP>; Sat, 26 May 2001 20:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbRE0ABH>; Sat, 26 May 2001 20:01:07 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20146 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262659AbRE0AAz>;
	Sat, 26 May 2001 20:00:55 -0400
Date: Sat, 26 May 2001 22:48:46 +1000
From: Gavin <glang02@dingoblue.net.au>
To: linux-kernel@vger.kernel.org
Subject: umount segfault on shutdown
Message-Id: <20010526224846.0b1df420.glang02@dingoblue.net.au>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Hope this is enough info :P

Unmounting file systems: journal_begin called without kernel lock held
kernel BUG at journal.c:423!
423: invalid operand: 0000
CPU: 0
EIP: 0010: [<c016d740>]
EFLAGS: 00010286
eax: 0000001d ebx: c42edf38 ecx: 00000001 edx:00000001
esi: c12dc800 edi: c42edf38 ebp: 0000000a esp: c42eded0

that's all I wrote down. There was more, please reply to reply-to if
you need more info and anything else I can do to provide more
information. Running Via apollo pro-a on smp MSI694D pro/2x366
reiserfs on /dev/hde8 (/usr) <promise ata100 controller> which seems
to be the cause of the segfault. I can reproduce this everytime with
2.4.5, doesn't happen with earlier versions.

best regards,
Gavin
