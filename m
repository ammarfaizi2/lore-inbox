Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbSJGTVy>; Mon, 7 Oct 2002 15:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbSJGTVy>; Mon, 7 Oct 2002 15:21:54 -0400
Received: from klee.cb.uni-bonn.de ([131.220.219.81]:522 "EHLO
	klee.cb.uni-bonn.de") by vger.kernel.org with ESMTP
	id <S262563AbSJGTVw> convert rfc822-to-8bit; Mon, 7 Oct 2002 15:21:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Harald van Pee <pee@iskp.uni-bonn.de>
To: linux-kernel@vger.kernel.org
Subject: strange smp problem with 2.4.19 not seen with rc1
Date: Mon, 7 Oct 2002 21:27:25 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210072127.25092.pee@iskp.uni-bonn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use two programs, the first one writes to a pipe, the other reads from it 
(houndreds of MB).

I have no problem with kernel 2.4.19-rc1 smp,
but with  2.4.19 (smp) the program stops (I don't know why, but it seems its 
always at the same file position).
I can kill the start script and the reading program, but the writing one 
leaves in D state.

ps -eo cmd,wchan

reports wchan lock_page.
(can't reproduce the details because its a production system and I have 
switched back to 2.4.19-rc1).

I have seen this problem only with smp machines and smp kernel versions.
It makes no difference if I run the kernel on an Asus A7M266-D or
a supermicro P3TDE6. The none smp Version of 2.4.19 have no problem on single 
processor boards.

The system itself is very stable! Both have 3ware controlers, but on the Asus 
board the 3ware disks are not mounted and not used.
I use the same .config file for 2.4.19-rc1 and 2.4.19

My questions are:
- Is it a known problem and fixed?
- Is it possible that I have a missconfigured kernel if its stable and I use 
the same .config file as for 2.4.19-rc1?
- Which kernel version should I use?

Regards
Harald
