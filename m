Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRDAKNy>; Sun, 1 Apr 2001 06:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132126AbRDAKNo>; Sun, 1 Apr 2001 06:13:44 -0400
Received: from mystique.daimi.au.dk ([130.225.18.94]:39439 "EHLO
	mystique.daimi.au.dk") by vger.kernel.org with ESMTP
	id <S132145AbRDAKNi>; Sun, 1 Apr 2001 06:13:38 -0400
X-Mozilla-Status: 0001
Message-ID: <3AC6FF09.1F7B0A89@daimi.au.dk>
Date: Sun, 01 Apr 2001 10:12:25 +0000
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.16-3 i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in proc permition checks.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere between 2.2.16 and 2.4.1 a bug in
vfs_permission() in the file "fs/namei.c" has
been fixed. S_ISDIR(mode) was incorrect,
S_ISDIR(inode->i_mode) is correct.

The same piece of code exist in the proc
filesystem, here the bug has not been fixed.

I wonder why does the function exist in the
proc filesystem, shouldn't proc be able to
use the default permission cheks?


I have also found a lot of bugs in the file
arch/i386/kernel/vm86.c, this is not mentioned
in the maintainer list. Is there a maintainer
I can send a bug report to? If not I will try
to fix the bugs on my own.


-- 
Kasper Dupont
