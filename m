Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRC2SPy>; Thu, 29 Mar 2001 13:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRC2SPo>; Thu, 29 Mar 2001 13:15:44 -0500
Received: from mailhost.aurora-linux.com ([212.81.103.10]:54789 "HELO
	mailhost.aurora-linux.com") by vger.kernel.org with SMTP
	id <S132806AbRC2SPh>; Thu, 29 Mar 2001 13:15:37 -0500
Date: Thu, 29 Mar 2001 20:20:32 +0000 (UTC)
From: Xavier Ordoquy <xordoquy@aurora-linux.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in the file attributes ?
Message-ID: <Pine.LNX.4.21.0103292011480.20805-100000@ilaws.aurora-linux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just made a manipulation that disturbs me. So I'm asking whether it's a
bug or a features.

user> su
root> echo "test" > test
root> ls -l
-rw-r--r--   1 root     root            5 Mar 29 19:14 test
root> exit
user> rm test
rm: remove write-protected file `test'? y
user> ls test
ls: test: No such file or directory

This is in the user home directory.
Since the file is read only for the user, it should not be able to remove
it. Moreover, the user can't write to test.
So I think this is a bug.

---
 Xavier Ordoquy, Aurora-linux
 If NT is the answer, you didn't understand the question.

