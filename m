Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWHDJ5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWHDJ5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWHDJ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:57:52 -0400
Received: from mail.jambit.com ([62.245.207.83]:46785 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S1030248AbWHDJ5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:57:52 -0400
Message-ID: <44D319A4.703@gmx.net>
Date: Fri, 04 Aug 2006 11:55:48 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.37 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.37, which can be found at the
location in the .sig.

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

readlinkat.2
    mtk (after prompting from Ivana Varekova)
        New page for readlinkat(2), new in kernel 2.6.16.

No new pages in this release, but a few new files with meta-information:


Changes to individual pages
---------------------------

capabilities.7
    mtk
        Added material on privileges required for move_pages().
        CLONE_NEWNS needs CAP_SYS_ADMIN.
        keyctl(KEYCTL_CHOWN) and keyctl(KEYCTL_SETPERM) require
        CAP_SYS_ADMIN.

=====================================================

May things need to be fixed in the manual pages, and any help with these
points would be appreciated.  Nowadays, there is a script in the tarball
that displays the FIXMEs.  For section 2, it says:

$ sh scripts/FIXME_list.sh man2
==========
man2/chroot.2
     FIXME -- eventually say something about containers,
     virtual servers, etc.?

==========
man2/fcntl.2
     FIXME According to POSIX.1-2001, O_SYNC should also be modifiable
     via fcntl(2), but currently Linux does not permit this
     See http://bugzilla.kernel.org/show_bug.cgi?id=5994

     FIXME The statement that O_ASYNC can be used in open() does not
     match reality; setting O_ASYNC via open() does not seem to be
     effective.
     See http://bugzilla.kernel.org/show_bug.cgi?id=5993

     FIXME Dec 04: some limited testing on alpha and ia64 seems to
     indicate that ANY negative PGID value will cause F_GETOWN
     to misinterpret the return as an error. Some other architectures
     seem to have the same range check as x86.  Must document
     the reality on other architectures -- MTK

==========
man2/get_mempolicy.2
     FIXME writeme -- no errors are listed on this page

==========
man2/madvise.2
     FIXME 2.6.16 added MADV_REMOVE, MADV_DONTFORK, and MADV_DOFORK.
     These need to be documented.
        MADV_REMOVE         /* remove these pages & resources */
        MADV_DONTFORK       /* don't inherit across fork */
        MADV_DOFORK         /* do inherit across fork */
         A discussion of MADV_DONTFORK and MADV_DOFORK can be found
        at http://lwn.net/Articles/171941/

==========
man2/mount.2
     FIXME 2.6.15 added flags for "shared sub-tree" functionality:
     MS_UNBINDABLE, MS_PRIVATE, MS_SHARED, MS_SLAVE
     These need to be documented on this page.
     See Documentation/sharedsubtree.txt

     FIXME Say more about MS_MOVE

     FIXME Document MS_REC, available since 2.4.11.
     This flag has meaning in conjunction with MS_BIND and
     also with the shared sub-tree flags.

     FIXME Can MNT_FORCE result in data loss?  According to
     the Solaris manual page it can cause data loss on Solaris.
     If the same holds on Linux, then this should be documented.

==========
man2/open.2
     FIXME? The O_NOATIME flag also affects the treatment of st_atime
     by mmap() and readdir(2), MTK, Dec 04.

     FIXME Check bugzilla report on open(O_ASYNC)
     See http://bugzilla.kernel.org/show_bug.cgi?id=5993

==========
man2/path_resolution.2
     FIXME say something about filesystem mounted read-only ?

     FIXME say something about immutable files
     FIXME say something about ACLs

==========
man2/prctl.2
     FIXME The following (applicable only on IA-64) are not currently
     described: PR_SET_UNALIGN, PR_GET_UNALIGN, PR_SET_FPEMU, PR_GET_FPEMU

==========
man2/quotactl.2
     FIXME There is much that is missing and/or out of date in this page.
     As things stand the page more or less documents Linux 2.2 reality:

     Linux 2.2 has:

        Q_GETQUOTA
        Q_GETSTATS
        Q_QUOTAOFF
        Q_QUOTAON
        Q_RSQUASH (not currently documented)
        Q_SETQLIM
        Q_SETQUOTA
        Q_SETUSE
        Q_SYNC

     Linux 2.4 has:

        Q_COMP_QUOTAOFF
        Q_COMP_QUOTAON
        Q_COMP_SYNC
        Q_GETFMT
        Q_GETINFO
        Q_GETQUOTA
        Q_QUOTAOFF
        Q_QUOTAON
        Q_SETINFO
        Q_SETQUOTA
        Q_SYNC
        Q_V1_GETQUOTA Q_V1_GETSTATS Q_V1_RSQUASH Q_V1_SETQLIM
        Q_V1_SETQUOTA Q_V1_SETUSE
        Q_V2_GETINFO Q_V2_GETQUOTA Q_V2_SETFLAGS Q_V2_SETGRACE
        Q_V2_SETINFO Q_V2_SETQUOTA Q_V2_SETUSE
        Q_XGETQSTAT Q_XGETQUOTA Q_XQUOTAOFF Q_XQUOTAON Q_XQUOTARM
        Q_XSETQLIM

     Linux 2.6.16 has:

        Q_GETFMT
        Q_GETINFO
        Q_GETQUOTA
        Q_QUOTAOFF
        Q_QUOTAON
        Q_SETINFO
        Q_SETQUOTA
        Q_SYNC
        Q_XGETQSTAT
        Q_XGETQUOTA
        Q_XQUOTAOFF
        Q_XQUOTAON
        Q_XQUOTARM
        Q_XQUOTASYNC
        Q_XSETQLIM

==========
man2/sched_setscheduler.2
     FIXME make some general statement about Unix implementations
     A process calling
     .BR sched_setscheduler
     needs an effective user ID equal to the real user ID or effective
     user ID of the process identified by
     .IR pid ,
     or it must be privileged (Linux: have the
     .B CAP_SYS_NICE
     capability).

==========
man2/select.2
     FIXME select() (and pselect()?) also modify the timeout
     on an EINTR error return; POSIX.1-2001 doesn't permit this.

==========
man2/send.2
     FIXME? document MSG_PROXY (which went away in 2.3.15)

==========
man2/set_mempolicy.2
     FIXME writeme -- no errors are listed on this page

==========
man2/shmop.2
     FIXME What does "failing attach at brk" mean?  (Is this phrase
     just junk?)

     FIXME A good explanation of the rationale for the existence
     of SHMLBA would be useful here

     FIXME That last sentence isn't true for all Linux
     architectures (i.e., SHMLBA != PAGE_SIZE for some architectures)
     -- MTK, Nov 04


=======================================================

The man-pages set contains sections 2, 3, 4, 5, and 7 of
the manual pages.  These sections describe the following:

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

If you make a change to a kernel-userland interface, or observe
a discrepancy between the manual pages and reality, would you
please send me (at mtk-manpages@gmx.net ) one of the following
(in decreasing order of preference):

1. An in-line "diff -u" patch with text changes for the
   corresponding manual page.  (The most up-to-date version
   of the manual pages can always be found at
   ftp://ftp.win.tue.nl/pub/linux-local/manpages or
   ftp://ftp.kernel.org/pub/linux/docs/manpages .)

2. Some raw text describing the changes, which I can then
   integrate into the appropriate manual page.

3. A message alerting me that some part of the manual pages
   does not correspond to reality.  Eventually, I will try to
   remedy the situation.

Obviously, as we get further down this list, more of my time
is required, and things may go slower, especially when the
changes concern some part of the kernel that I am ignorant
about and I can't find someone to assist.

Cheers,

Michael

