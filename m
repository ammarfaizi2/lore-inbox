Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136498AbRAHKLR>; Mon, 8 Jan 2001 05:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136602AbRAHKK6>; Mon, 8 Jan 2001 05:10:58 -0500
Received: from Prins.externet.hu ([212.40.96.161]:36616 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S136498AbRAHKKr>; Mon, 8 Jan 2001 05:10:47 -0500
Date: Mon, 8 Jan 2001 11:10:45 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: linux-kernel@vger.kernel.org
Subject: postgres/shm problem
Message-ID: <Pine.LNX.4.02.10101081110001.1837-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel developers!

Lots of things may have changed in 2.4.0-prer., because nor cdrecord
neither postgressql do not run because of system v ipc / shm problem.
After recompiling cdrecord with the new header files, started working.
I'm just recompiling postgres too.

/var/log/postgresql.log:

010102.10:45:09.448   [627] IpcMemoryCreate: shmget failed (No space left
on device) key=5432010, size=144, permission=700
This type of error is usually caused by an improper
shared memory or System V IPC semaphore configuration.
For more information, see the FAQ and platform-specific
FAQ's in the source directory pgsql/doc or on our
web site at http://www.postgresql.org.
010102.10:45:09.481   [627] IpcMemoryIdGet: shmget failed (No such file or
directory) key=5432010, size=144, permission=0
010102.10:45:09.481   [627] IpcMemoryAttach: shmat failed (Invalid
argument) id=-2
010102.10:45:09.482   [627] FATAL 1:  AttachSLockMemory: could not attach
segment
010105.08:52:27.995 [12675] IpcMemoryCreate: shmget failed (No space left
on device) key=5432010, size=144, permission=700

cdrecord says the same no space left on device mesg.

Is there any other solution than recompiling programs?
all of the program which need shm/ipc will turn blue?

kernel 2.4.0-prerelease
postgresql                 7.0.3-2 postgresql                 7.0.3-2 
cdrecord 1.9


thx
Narancs v1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
