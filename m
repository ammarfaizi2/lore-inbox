Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVJLQ06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVJLQ06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVJLQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:26:58 -0400
Received: from mail.gmx.de ([213.165.64.21]:39905 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964804AbVJLQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:26:57 -0400
Date: Wed, 12 Oct 2005 18:26:55 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net, Andries.Brouwer@cwi.nl
MIME-Version: 1.0
References: <434D5224.9754.10AC691@localhost>
Subject: man-pages-2.08 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <30041.1129134415@www32.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.08, which contains 
sections 2, 3, 4, 5, and 7 of the manual pages.  These 
sections describe the following:

2: (Linux) system calls
3: (libc) library functions
4: Devices
5: File formats and protocols
7: Overview pages, conventions, etc.

As far as this list is concerned the most relevant parts are: 
all of sections 2 and 4, which describe kernel-userland interfaces; 
in section 5, the proc(5) manual page, which attempts (it's always 
catching up) to be a comprehensive description of /proc; and 
various pages in section 7, some of which are overview pages of 
kernel features (e.g., networking protocols).

This is a request to kernel developers: if you make a change 
to a kernel-userland interface, or observe a discrepancy 
between the manual pages and reality, would you please send 
me (at mtk-manpages@gmx.net ) one of the following 
(in decreasing order of preference):

1. An in-line "diff -u" patch with text changes for the 
   corresponding manual page.  (The most up-to-date version 
   of the manual pages can always be found at
   ftp://ftp.win.tue.nl/pub/linux-local/manpages or
   ftp://ftp.kernel.org/pub/linux/docs/manpages .)

2. An email describing the changes, which I can then 
   integrate into the appropriate manual page.

3. A message alerting me that some part of the manual pages 
   does not correspond to reality.  Eventually, I will try to 
   remedy the situation.

Obviously, as we get further down this list, more of my time 
is required, and things may go slower, especially when the
changes concern some part of the kernel that I am ignorant 
about and I can't find someone to assist.

To give an idea of the kinds of things that are desired as 
manual page additions/improvements, I've shown extracts from 
the man-pages-2.08 Changelog below.

Cheers,

Michael

==================== Changes in man-pages-2.08 ====================

connect.2
        Add EINTR error

getpriority.2
        Expanded discussion of relationship between user and kernel
            representations of the nice value.
        Added discussion of RLIMIT_NICE and a cross reference to
            getrlimit.2 under the description of the EACCES error.
        Noted 2.6.12 change in credentials checking for setpriority().

getrlimit.2
        Added description of RLIMIT_RTPRIO
        Added description of RLIMIT_NICE

mmap.2
        Noted bug in MAP_POPULATE for kernels before 2.6.7.

mremap.2
        Added _GNU_SOURCE to prototype.
        Rewrote description of MREMAP_MAYMOVE.
        Rewrote description of EAGAIN error.
        Added discussion of resizing of memory locks.

msgctl.2
        Added IPC_INFO, MSG_INFO, MSG_STAT descriptions.

prctl.2
        Since kernel 2.6.13 PR_SET_DUMPABLE can also have the value 2.

remap_file_pages.2
        Added text to note that start and size are both rounded 
        downwards.

sched_setparam.2
       Modified discussion of privileges; added pointer to
           sched_setscheduler.2 for a discussion of privileges and
           resource limits.

sched_setscheduler.2
       Modified discussion of privileges; added discussion of 
       RLIMIT_RTPRIO.

semctl.2
        Added IPC_INFO, SEM_INFO, SEM_STAT descriptions.

shmctl.2
        Added IPC_INFO, SHM_INFO, SHM_STAT descriptions.

sigaction.2
        Split sigpending(), sigprocmask(), and sigsuspend() out
        into separate new pages.

sigpending.2
        New page created by splitting out from sigaction.2

sigprocmask.2
        New page created by splitting out from sigaction.2
        Added text on effect of NULL for 'set' argument.
        Added text noting effect of ignoring SIGBUS, SIGFPE, SIGILL,
                and SIGSEGV.
        Noted that sigprocmask() can't be used in multithreaded process.
        Fixed EINVAL error diagnostic.

sigsuspend.2
        New page created by splitting out from sigaction.2
        Added NOTES on usage.

stat.2
        Improve st_blocks description.

getaddrinfo.3
        Nowadays (since 2.3.4) glibc only sets the first ai_canonname
        field if AI_CANONNAME was specified (the current behavior
        is all that SUSv3 requires).

        1,$s/PF_/AF_/g

        Added descriptions of AI_ALL, AI_ADDRCONFIG, AI_V4MAPPED,
        and AI_NUMERICSERV.

setenv.3
        glibc 2.3.4 fixed the "name contains '='" bug

proc.5
        Improve text describing /proc/sys/fs/mqueue/* files

        Describe /proc/sys/fs/suid_dumpable (new in 2.6.13)

        Added placeholder mention of /proc/zoneinfo (new in 2.6.13)
            More needs to be said about this file

        Repaired earlier cut and paste mistake which resulted
            in part of the text of this page being duplicated.

capabilities.7
        Added CAP_AUDIT_CONTROL and CAP_AUDIT_WRITE.

ip.7
        Fix discussion of IPC_RECVTTL / IP_TTL

socket.7
        Clarified details of use of SO_PEERCRED.

udp.7
        Added description of UDP_CORK socket option

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
