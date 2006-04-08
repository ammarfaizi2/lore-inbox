Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWDHVHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWDHVHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWDHVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 17:07:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:65181 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751432AbWDHVHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 17:07:37 -0400
Date: Sat, 8 Apr 2006 23:07:36 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <5159.1143403544@www006.gmx.net>
Subject: man-pages-2.29 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <877.1144530456@www042.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.29, which can be found at the 
location in the .sig.  A list of some notable changes can be found
further down in this message

*** A request ***

Manual pages for the follwoing system calls are notably absent
from the man-pages set.  Contributions would be most welcome.

add_key(2)              (new in kernel 2.6.10)
keyctl(2)               (new in kernel 2.6.10)
request_key(2)          (new in kernel 2.6.10)
    See:
        Documentation/keys.txt
        Documentation/keys-request-key.txt

ioprio_get(2)           (new in kernel 2.6.13)
ioprio_set(2)           (new in kernel 2.6.13)
    See:
        Documentation/block/ioprio.txt

restart_syscall(2)      (new in kernel 2.6)

kexec_load(2)           (new in kernel 2.6.13)

migrate_pages(2)        (new in kernel 2.6.16)
                        See Documentation/vm/page_migration

2.29 Changes
============

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

mkdirat.2
    mtk
        New page describing mkdirat(2), new in 2.6.16.

mknodat.2
    mtk
        New page describing mknodat(2), new in 2.6.16.

core.5
    mtk
        New page describing core dump files.

mkfifoat.3
    mtk
        New page describing mkfifoat(3).


Changes to individual pages
---------------------------

getrlimit.2
    mtk
        Added BUGS text on 2.6.x handling of RLIMIT_CPU limit
        of zero seconds.  See
        http://marc.theaimsgroup.com/?l=linux-kernel&m=112256338703880&w=2

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
