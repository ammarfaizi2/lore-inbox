Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280828AbRKTCHD>; Mon, 19 Nov 2001 21:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKTCGw>; Mon, 19 Nov 2001 21:06:52 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:14266 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S280828AbRKTCGo>; Mon, 19 Nov 2001 21:06:44 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111200206.CAA07946@mauve.demon.co.uk>
Subject: Can't link?
To: linux-kernel@vger.kernel.org
Date: Tue, 20 Nov 2001 02:06:35 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather odd thing happening right now, that I can't figure out.

Running 2.4.11 on a ext2 filesystem, with a couple of 40Gb drives, and 
some NFS mounts.

After reading man link, I tried the following in /

bash-2.03# >1 
bash-2.03# ls -l
total 0
-rw-r--r--   1 root     root            0 Nov 20 01:57 1
bash-2.03# ln 1 2
ln: cannot create hard link `2' to `1': No such file or directory

With strace:
stat("1", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
lstat("2", 0xbffff824)                  = -1 ENOENT (No such file or directory)
lstat("2", 0xbffff824)                  = -1 ENOENT (No such file or directory)
link("1", "2")                          = -1 ENOENT (No such file or directory)

I tried this with root, as shown above, when I encountered bizarre problems
due to tin not being able to rename files.

