Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWCZUFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWCZUFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWCZUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:05:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:5594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751512AbWCZUFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:05:46 -0500
Date: Sun, 26 Mar 2006 22:05:44 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <23302.1142902111@www002.gmx.net>
Subject: man-pages-2.27 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <5159.1143403544@www006.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.27, which can be found at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

or:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

This release includes various changes that may be significant 
for readers of this list, including documentation on various new
kernel 2.6.16 interfaces, listed further down in this message.

At the moment, manual pages for the following system calls
are notably absent:

add_key(2)          (new in 2.6.10)
keyctl(2)           (new in 2.6.10)
request_key(2)      (new in 2.6.10)
    See:
        Documentation/keys.txt
        Documentation/keys-request-key.txt

        
ioprio_get(2)       (new in kernel 2.6.13) 
ioprio_set(2)       (new in kernel 2.6.13)
    See Documentation/block/ioprio.txt


restart_syscall(2)  (new in 2.6)
kexec_load(2)       (new in kernel 2.6.13)

migrate_pages(2)    (new in 2.6.16)
                    See Documentation/vm/page_migration

New manual pages for the above system calls would be most 
welcome.

2.27 Changes
============

Notable changes in this release include the following:

New pages
---------

ushare.2
    mtk, with reference to documentation by Janak Desai
        New page describing unshare(2), added in kernel 2.6.16.


Changes to individual pages
---------------------------

ptrace.2
    Chuck Ebbert, with assistance from Daniel Jacobowitz, 
    Paolo (Blaisorblade) Giarrusso, and Charles P. Wright;
    after a suggestion from Heiko Carstens.
        Document the following ptrace requests: 
            PTRACE_SETOPTIONS (2.4.6)
                plus associated flags:
                    PTRACE_O_TRACESYSGOOD (2.4.6)
                    PTRACE_O_TRACEFORK (2.5.46)
                    PTRACE_O_TRACEVFORK (2.5.46)
                    PTRACE_O_TRACECLONE (2.5.46)
                    PTRACE_O_TRACEEXEC (2.5.46)
                    PTRACE_O_TRACEVFORKDONE (2.5.60)
                    PTRACE_O_TRACEEXIT (2.5.60)
            PTRACE_SETSIGINFO (2.3.99-pre6)
            PTRACE_GETSIGINFO (2.3.99-pre6)
            PTRACE_GETEVENTMSG (2.5.46)
            PTRACE_SYSEMU (since Linux 2.6.14)
            PTRACE_SYSEMU_SINGLESTEP (since Linux 2.6.14)
    
sched_get_priority_max.2
sched_setscheduler.2
sched_setparam.2
    mtk, Ingo Molnar
        Modified to document SCHED_BATCH policy, new in kernel 2.6.16.

        Text describing SCHED_BATCH was added to sched_setscheduler.2,
        and was drawn in part from Ingo Molnar's description in the
        mail message containing the patch that implemented this policy.

        Various other minor rewordings and formatting fixes.

proc.5
    mtk, using text from Documentation/filesystems/proc.txt
        Document /proc/sys/vm/drop_caches, new in kernel 2.6.16.
    mtk, using information from ChangeLog-2.6.14.
        Document /proc/PID/smaps, new in kernel 2.6.14.

capabilities.7
    mtk
        Noted affect of CAP_SYS_NICE for mbind(MPOL_MF_MOVE_ALL).

pthreads.7
    mtk
        Kernel 2.6.16 eliminated buggy behaviour with respect to
        the alternate signal stack.

==========

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

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
