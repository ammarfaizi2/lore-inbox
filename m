Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSGWRAR>; Tue, 23 Jul 2002 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSGWRAR>; Tue, 23 Jul 2002 13:00:17 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:32858 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318161AbSGWRAP>; Tue, 23 Jul 2002 13:00:15 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114A3@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'Dr. Michael Weller'" <eowmob@exp-math.uni-essen.de>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Problem with msync system call
Date: Tue, 23 Jul 2002 20:00:55 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your comments.

>I must say I have a very uneasy feeling about such a usage and 
>don't know how it is covered by standards (although you claim it works for
non
>linux). Experience shows that such a construct is very 
>fragile. Note also that NFS file locking is not mandatory, only advisory
(read: 
>user level) and it is unclear how that will interact with mmap.

I agree that the construction is very fragile, but...

- It's been working on a variety of OSes for years... There is no reason for
Linux not to support it as a mature operating system.
- This works for read/write system calls if the file is open with O_SYNC
flag and NFS is mounted using "sync" option.
- There has to be something in the OS that users can do to unconditionally
reread mapped files (no matter if this is NFS or not)
- Even mandatory locking should be sufficient for mmap interaction if one
cares to flush information to the disk before the file is unlocked.
Suprisingly, locking is not the problem here :)

Best,
Giga

