Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWCUAsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCUAsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWCUAsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:48:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46550 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751389AbWCUAsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:48:32 -0500
Date: Tue, 21 Mar 2006 01:48:31 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <6194.1141336808@www004.gmx.net>
Subject: man-pages-2.26 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <23302.1142902111@www002.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.26, which can be found at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

or:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

This release includes various changes that may be significant 
for readers of this list, including documentation on various new
kernel 2.6.16 interfaces, listed further down in this message.

I'd like to request that any kernel developers who make changes 
to the kernel-userland interface (e.g., system calls, /proc,
netlink interfaces, etc.) do some or (preferably) all of the
following when initially submitting the patch (to, for example, 
the -mm tree):

   a) CC me at mtk-manpages@gmx.net,
   b) include or point me at some text that explains the 
      interface change (more on the preferred ways for doing 
      that below), and
   c) include or point me at userland test programs that 
      demonstrate/test the interface.

This will likely have two effects:

    * The process of getting the change documented in the man-pages
      once it enters mainline will be speeded up.

    * I will try testing the change (as time permits).  Even if
      you do c) above, I will typically still write my own
      test program(s), since I often like to test things in 
      additional ways.

New pages
---------

openat.2
    mtk
        New page describing openat(2), added in kernel 2.6.16,
        and some notes on rationale for the at*(2) system calls.

mbind.2
    Andi Kleen, Christoph Lameter, mtk
       Added MPOL_MF_MOVE and MPOL_MF_MOVE_ALL descriptions,
       from numactl-0.9.2 man page.

fexecve.3
    mtk
        New page describing fexecve(3).

futimes.3
    mtk
        New page describing futimes(3).

Apologies: The "Changes" file in the release mentions a new unshare.2 
page documenting the unshare() system call that is new in kernel 
2.6.16.  This manual page will only appear with man-pages-2.27.

Changes to individual pages
---------------------------

poll.2
    mtk
        Added discussion of ppoll(2), which is new in 2.6.16.
    
select.2
    mtk
        Updated to reflect the fact that pselect() has been implemented
        in the kernel in 2.6.16; various other minor wording changes.

netlink.7
    Hasso Tepper
        Substantial updates to various parts of this page.

pthreads.7
    mtk
        Updated to reflect that the NPTL limitation that only the main 
        thread could call setsid() and setpgid() was removed in 2.6.16.

socket.7
    mtk
        Documented SO_SNDBUFFORCE and SO_RCVBUFFORCE socket options,
        new in 2.6.14.

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
