Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWBIXJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWBIXJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWBIXJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:09:37 -0500
Received: from mail.gmx.net ([213.165.64.21]:39127 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750816AbWBIXJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:09:37 -0500
Date: Fri, 10 Feb 2006 00:09:35 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <16806.1139255986@www031.gmx.net>
Subject: man-pages-2.23 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <18893.1139526575@www004.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.23, which can be found at the 
location listed in the .sig.

This release includes the following new manual pages:

inotify_init.2
inotify_add_watch.2
inotify_rm_watch.2
    Robert Love, with some additions by mtk.
        New pages describing the inotify API.
    
inotify.7
    mtk
        Overview of the inotify API.

mbind.2
get_mempolicy.2
set_mempolicy.2
    Andi Kleen, with additional work by mtk
        New pages describing the NUMA memory allocation policy API.

rtc.4
    Urs Thuermann, with additional work by mtk
        New page describing the real-time clock driver.

Among other notable changes for existing pages are the following:

mlock.2
    mtk / Matthias Andree
        Added BUGS txt on interaction between MCL_FUTURE and
        RLIMIT_MEMLOCK.
        See the following LKML thread:
        http://marc.theaimsgroup.com/?l=linux-kernel&m=113801392825023&w=2
        "Rationale for RLIMIT_MEMLOCK"
        
sched_setaffinity.2
    mtk
        Major rewrite.

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
