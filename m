Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264440AbSIVRl2>; Sun, 22 Sep 2002 13:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264441AbSIVRl2>; Sun, 22 Sep 2002 13:41:28 -0400
Received: from [64.6.248.2] ([64.6.248.2]:30940 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S264440AbSIVRl1>;
	Sun, 22 Sep 2002 13:41:27 -0400
Date: Sun, 22 Sep 2002 10:46:31 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-ac4 ncpmount 
Message-ID: <Pine.LNX.4.44.0209221038300.21911-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I mount a Novell Netware file server on 2.4.19-ac4, I can access it
with a file browser (konqueror, lynx), but ls gives "Stale NFS file
handle" and other bash commands such as find fail. 2.4.16 works fine.

Cheers,
Peter

#strace ls
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ESTALE (Stale 
NFS file handle)
write(2, "ls: ", 4ls: )                     = 4
write(2, ".", 1.)                        = 1
write(2, ": Stale NFS file handle", 23: Stale NFS file handle) = 23
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?


