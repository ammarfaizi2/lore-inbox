Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbRGIOMH>; Mon, 9 Jul 2001 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbRGIOL6>; Mon, 9 Jul 2001 10:11:58 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:55469 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S264663AbRGIOLs>;
	Mon, 9 Jul 2001 10:11:48 -0400
Message-ID: <3B49BBA1.4CAD3187@Sun.COM>
Date: Mon, 09 Jul 2001 16:11:45 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Shared library interceptor/SIGSEGV
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have written a library for intercepting outgoing network connections,
and redirecting them through a proxy server.
The user had to set LD_PRELOAD to load my library, and my library
redefine the connect() function for INET sockets. It also uses
dlsym(RTLD_NEXT, "connect") to get the location of the 'real' libc
connect.

The problem is : when I run some programs (like cat, which doesn't use
connect), it causes a SIGSEGV, and strace doesn't help me more! It seems
that the segmentation fault occurs after a 'certain' number of syscalls,
but I can't figure why.

Does anybody know where could be the bug ?

Tnx.
--

    Julien Laganier
     Student Intern
Sun Microsystem Laboratories
