Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSERIee>; Sat, 18 May 2002 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSERIed>; Sat, 18 May 2002 04:34:33 -0400
Received: from hopi.hostsharing.net ([66.70.34.150]:61115 "EHLO
	hopi.hostsharing.net") by vger.kernel.org with ESMTP
	id <S293510AbSERIed>; Sat, 18 May 2002 04:34:33 -0400
Date: Sat, 18 May 2002 10:34:32 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: suid bit on directories
Message-Id: <20020518103432.5a3b4c67.michael@hostsharing.net>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am new on this list and thoroughly searched the FAQ, the archives and
the web for this question, but couldn't find anything.

We wondererd why setting the guid bit on a directory makes all new files
owned by the group of the directory, but this does not work for the suid
bit, making new files owned by the owner of the directory.

It would be a good solution to make files created by Apaches mod_php in
safe-mode, not owned by web:web (or httpd:httpd or somethign) anymore, but
the Owner of the directory. 

I do not even see a security hole if nobody other than the user itself and
httpd/web can reach this area in the file system, anyway. And it is still
the users decision that files in this (his) directory should belong to
him.

It seems, this has to be patched for each file system separately, right?
For example in linux/fs/ext2/ialloc.c.

Actually, the suid bit on directories works at least under FreeBSD. Is
there any reason, why it does not work under Linux?

Thanks
	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
