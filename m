Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKTS1Q>; Mon, 20 Nov 2000 13:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQKTS1G>; Mon, 20 Nov 2000 13:27:06 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:39128 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129345AbQKTS04>; Mon, 20 Nov 2000 13:26:56 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Bug in large files ext2 in 2.4.0-test11 ?
Message-ID: <3A1965E2.6BE6AF2@fi.muni.cz>
Date: Mon, 20 Nov 2000 17:56:50 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 8bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just noticed this problem - 
I'm missing some large files created in the filesystem.

This is 'ls' output from 2.4.0-test11/test10
total 33
drwxr-xr-x    6 root     root         4096 Nov 20 18:06 .
drwxr-xr-x   42 root     root         1024 Nov 20 14:02 ..
drwxr-xr-x    2 root     root         4096 Nov 19 15:50 X
drwxr-xr-x    2 root     root        16384 Sep 30 18:45 lost+found
ls: zero: Value too large for defined data type


And this is same directory with 2.2.17pre9
total 4561569
drwxr-xr-x    6 root     root         4096 lis 20 18:06 .
drwxr-xr-x   42 root     root         1024 lis 20 14:02 ..
drwxr-xr-x    2 root     root        16384 záø 30 18:45 lost+found
drwxr-xr-x    2 root     root         4096 lis 19 15:50 X
-rw-r--r--    1 root     root     4294967295 lis 20 18:08 zero


Thought the 'zero' file has been created in 2.4.0-test11
I can't see it again with this kernel.

I would assume this is some problem of the kernel,
but maybe its incompatibility in libc - anyway I'm using
uptodate Debian Woody if this helps.

bye

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
