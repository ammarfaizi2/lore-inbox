Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQKADqP>; Tue, 31 Oct 2000 22:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131196AbQKADp4>; Tue, 31 Oct 2000 22:45:56 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:65036 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129562AbQKADpp>;
	Tue, 31 Oct 2000 22:45:45 -0500
Message-Id: <200011010453.XAA23218@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.32-2.4.0-test10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 23:53:23 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.0-test10 is available.

The stack overflows seen in test9 are fixed.  The stack is now allocated as 
four pages, the top two used as a kernel stack, the third is inaccessible and 
acts as a guard page, and the lowest page contains the task structure.

Host devices can again be mounted inside the virtual machine.  This was broken 
a few releases ago when I made the block driver check io requests against the 
device size.

It will no longer crash if the main console is not a terminal.

I fixed a race which was causing strange kernel memory faults.

In the sources (the patch and cvs), but not the binaries, there is the 
beginning of a hostfs filesystem.  This gives you access to the host root 
filesystem.  Doing 'mount none /wherever -t hostfs' will mount the host root 
filesystem on /wherever.  Right now, you can mount it and cd into it, but ls 
will crash the kernel.

The project's home page is http://user-mode-linux.sourceforge.net

The project's download page is http://sourceforge.net/project/filelist.php?grou
p_id=429

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
