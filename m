Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTBFT7x>; Thu, 6 Feb 2003 14:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267609AbTBFT7x>; Thu, 6 Feb 2003 14:59:53 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31909 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267605AbTBFT7r>;
	Thu, 6 Feb 2003 14:59:47 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 21:09:24 +0100 (MET)
Message-Id: <UTC200302062009.h16K9Op23604.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: syscall documentation (3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next new page is tkill.2

Comments welcome.
Andries
aeb@cwi.nl

-----------------------------------
NAME
       tkill - send a signal to a single process

SYNOPSIS
       #include <sys/types.h>
       #include <linux/unistd.h>

       _syscall2(int, tkill, pid_t, tid, int, sig)

       int tkill(pid_t tid, int sig);

DESCRIPTION
       The tkill system call is analogous to kill(2), except when
       the specified process is part of a thread  group  (created
       by specifying the CLONE_THREAD flag in the call to clone).
       Since all the processes in a thread group  have  the  same
       PID,  they  cannot  be  individually  signalled with kill.
       With tkill, however, one can address each process  by  its
       unique TID.

RETURN VALUE
       On  success,  zero  is returned. On error, -1 is returned,
       and errno is set appropriately.

ERRORS
       EINVAL An invalid TID or signal was specified.

       ESRCH  No process with the specified TID exists.

       EPERM  The caller did not have permission to send the sig­
              nal  to  the specified process. For a process to be
              allowed to send a signal, it must either have  root
              privileges,  or  its real or effective user ID must
              be equal to the real or saved  set-user-ID  of  the
              receiving process.

CONFORMING TO
       tkill is Linux specific and should not be used in programs
       that are intended to be portable.

SEE ALSO
       gettid(2), kill(2)

Linux 2.4.20                2003-02-01                   TKILL(2)
