Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSELQX1>; Sun, 12 May 2002 12:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSELQX0>; Sun, 12 May 2002 12:23:26 -0400
Received: from daimi.au.dk ([130.225.16.1]:38663 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315182AbSELQXZ>;
	Sun, 12 May 2002 12:23:25 -0400
Message-ID: <3CDE96F9.8443C446@daimi.au.dk>
Date: Sun, 12 May 2002 18:23:21 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] ext2 and ext3 block reservations can be bypassed
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Usually the last 5% of the diskspace on ext2 and ext3
filesystems are reserved for root. But I just realized
that they can be bypassed by redirecting the output
from a suid root program to a file.

This command will keep writing beyond the 95% limit:
while true ; do mount ; done >filename

This was tested on a 2.4.19-pre8-ac1 kernel. Does
this problem exist on all other kernels as well, and
how severe is this problem?

It might be better to only allow write() if the user
was also allowed to do that when open() was called.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
