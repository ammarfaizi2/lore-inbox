Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316042AbSEJP2F>; Fri, 10 May 2002 11:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSEJP2E>; Fri, 10 May 2002 11:28:04 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:57814 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S316042AbSEJP2D>; Fri, 10 May 2002 11:28:03 -0400
Date: Fri, 10 May 2002 18:37:21 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: <linux-kernel@vger.kernel.org>
Subject: mmap, SIGBUS, and handling it
Message-ID: <Pine.LNX.4.33.0205101832080.9661-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

One change in kernel 2.4.x is to send a SIGBUS signal to the process
trying to read a mmap section that is invalid.

Ex, if we have a file server, and that program gets a request for a file,
it does a mmap. After that starts serving the file to the client (by
write()-ing to the socket fd). If in the meantime some other process
truncates the file which was mmap-ed , our program will receive a SIGBUS
in write().

If I understand right this is more POSIX compliant.

Is there a clean/good way of handling this ?

PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
if set with signal(SIGBUS,handle_sigbus) ?

Thanks

----------------------------
Mihai RUSU

Disclaimer: Any views or opinions presented within this e-mail are solely
those of the author and do not necessarily represent those of any company,
unless otherwise specifically stated.

