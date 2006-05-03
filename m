Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWECX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWECX14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWECX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:27:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:45191 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751390AbWECX14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:27:56 -0400
Date: Thu, 4 May 2006 01:27:54 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <6194.1141336808@www004.gmx.net>
Subject: man-pages-2.31 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <20315.1146698874@www093.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.31, which can be found at the 
location listed in the .sig.

This release includes the following new manual pages:

fstatat.2
    mtk
        New page for fstatat(2), new in 2.6.16.

adjtime.3
    mtk
        New page for adjtime(3).

ftm.7
    mtk
        New page describing feature test macros.

time.7
    mtk
        New page giving an overview of "time" on Linux systems.

There are a number of known places where things need
to be fixed in the manual pages.  I have included a partial
list below.  Any help on these points would be most welcome.

==========

/home/mtk/man-pages/man2/madvise.2
     FIXME 2.6.16 added MADV_REMOVE, MADV_DONTFORK, and MADV_DOFORK.
     These need to be documented.
        MADV_REMOVE         /* remove these pages & resources */
        MADV_DONTFORK       /* don't inherit across fork */
        MADV_DOFORK         /* do inherit across fork */
        A discussion of MADV_DONTFORK and MADV_DOFORK can be found
        at http://lwn.net/Articles/171941/

==========
/home/mtk/man-pages/man2/mount.2
     FIXME 2.6.15 added flags for "shared sub-tree" functionality:
     MS_UNBINDABLE, MS_PRIVATE, MS_SHARED, MS_SLAVE
     These need to be documented on this page.
     See Documentation/sharedsubtree.txt

     FIXME Say more about MS_MOVE

     FIXME Document MS_REC, available since 2.4.11.
     This flag has meaning in conjunction with MS_BIND and
     also with the shared sub-tree flags.

     FIXME Since Linux 2.6.16, MS_NODIRATIME and MS_NOATIME are
     also settable on a per-mount basis

     FIXME Can MNT_FORCE result in data loss?  According to
     the Solaris manual page it can cause data loss on Solaris.
     If the same holds on Linux, then this should be documented.

==========
/home/mtk/man-pages/man2/quotactl.2
     FIXME There is much that is missing and/or out of date in this page.
     As things stand the page more or less documents Linux 2.2 reality:

==========
/home/mtk/man-pages/man2/shmop.2
     FIXME What does "failing attach at brk" mean?  (Is this phrase
     just junk?)

     FIXME A good explanation of the rationale for the existence
     of SHMLBA would be useful here

==========
/home/mtk/man-pages/man5/acct.5
     FIXME this page needs to say a lot more, including mentioning
        Version 3 format process accounting on Linux.

==========
/home/mtk/man-pages/man5/proc.5
     FIXME 2.6.14 has /proc/PID/numa_maps (if CONFIG_NUMA is
     enabled); this needs to be documented.
     Info on numa_maps can be found in the patch-2.6.14
     Changelog, but this is possibly not up to date.

     FIXME 2.6.13 seems to have /proc/vmcore implemented
     in the source code, but there is no option available under
     'make xconfig'; eventually this should be fixed, and then info
     from the patch-2.6.13 and change log could be used to write an
     entry in this man page.

     FIXME 2.6.17-rc1 has /proc/PID/mountstats and
     /proc/PID/task/TID/mountstats; these need to be documented
     Some information can be found in the 2.6.17-rc1 change log.

     FIXME cross check against Documentation/filesystems/proc.txt
     to see what information could be imported from that file
     into this file.

     FIXME Describe /proc/[number]/loginuid
           Added in 2.6.11; updating requires CAP_AUDIT_CONTROL

     FIXME Describe /proc/[number]/oom_adj
           Added in 2.6.11; updating requires CAP_SYS_RESOURCE
           Mention OOM_DISABLE (-17)
     FIXME Describe /proc/[number]/oom_score
           Added in 2.6.11; read-only

     FIXME Describe /proc/[number]/seccomp
           Added in 2.6.12

     FIXME Document /proc/config.gz (new in kernel 2.6)

     FIXME Actually, the following info abut the /proc/stat 'cpu' field
           does not seem to be quite right (at least in 2.6.12)

     FIXME 2.6.11 adds a further column "steal" (see
           fs/proc/proc_misc.c); this is not yet described...

     FIXME The following is not the full picture for the 'intr' of
           /proc/stat on 2.6:

     FIXME more should be said about /proc/zoneinfo

==========
/home/mtk/man-pages/man7/netlink.7
     FIXME More details on NETLINK_INET_DIAG needed.

     FIXME More details on NETLINK_XFRM needed.

     FIXME More details on NETLINK_ISCSI needed.

     FIXME More details on NETLINK_AUDIT needed.

     FIXME More details on NETLINK_FIB_LOOKUP needed.

     FIXME More details on NETLINK_NETFILTER needed.

     FIXME More details on NETLINK_KOBJECT_UEVENT needed.

     FIXME NLM_F_ATOMIC is not used any more?

     FIXME Explain more about nlmsg_seq and nlmsg_pid.

==========
/home/mtk/man-pages/man7/tcp.7
     FIXME 2.6.17-rc1 adds the following /proc files, which need to
          documentedtcp_mtu_probing, tcp_base_mss, and
          tcp_workaround_signed_windows

     FIXME As at 14 Jun 2005, kernel 2.6.12, the following are
        not yet documented (shown with default values):

         /proc/sys/net/ipv4/tcp_bic_beta
         819
         /proc/sys/net/ipv4/tcp_moderate_rcvbuf
         1
         /proc/sys/net/ipv4/tcp_no_metrics_save
         0
         /proc/sys/net/ipv4/tcp_vegas_alpha
         2
         /proc/sys/net/ipv4/tcp_vegas_beta
         6
         /proc/sys/net/ipv4/tcp_vegas_gamma
         2

     FIXME Document TCP_CONGESTION (new in 2.6.13)

==========
/home/mtk/man-pages/man7/udp.7
     FIXME document UDP_ENCAP (new in kernel 2.5.67)

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
