Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315916AbSEGRbc>; Tue, 7 May 2002 13:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315917AbSEGRbb>; Tue, 7 May 2002 13:31:31 -0400
Received: from [64.114.5.49] ([64.114.5.49]:50446 "EHLO c2kosmtp.cucbc.com")
	by vger.kernel.org with ESMTP id <S315916AbSEGRba>;
	Tue, 7 May 2002 13:31:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Fillman <jfillman@cucbc.com>
Organization: CUCBC
To: linux-kernel@vger.kernel.org
Subject: Question about Virtual Memory
Date: Tue, 7 May 2002 10:27:09 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <C2KXCHtyi67EKRuYDlr000004c8@c2kxch.cucbc.com>
X-OriginalArrivalTime: 07 May 2002 17:31:20.0920 (UTC) FILETIME=[00998580:01C1F5ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I'm trying to understand how the 2.4 kernel behaves with respect to 
caching. I'm running the 2.4.17 kernel on an i686. The server is running 
heartbeat, apache, tomcat, and a java based message routing application. 99% 
of the work is comming from the java application which produces a lot of disk 
and network I/O. 
Am I correct in saying that the kernel will cache disk writes to memory if 
there is ample free RAM? Then syncing it to disk at a later time?

With the above mentioned applications NOT running, %swapused = 0, disk cache 
= 0. I've observed that when the applications start up, the kernel slowly 
starts allocating free RAM for caching. It will stabalize with ~6MB of RAM 
free. That's fine. But what I don't understand is that at the same time, swap 
usage starts to increase and after a day or so, stabalizes at ~15MB. What is 
being  swapped out? Is the VMM utilizing swap when it's caching?

cheers,
James Fillman
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82A5tB2UIX/PVkc0RAua2AJ9z15e5NJ8dCIG40TH3hCRHAji1ggCgkXAW
sVdvkIaqPwAktfxlsTdM1ac=
=Q/JS
-----END PGP SIGNATURE-----
