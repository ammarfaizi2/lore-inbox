Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWJFRtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWJFRtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJFRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:49:18 -0400
Received: from smtp.rdslink.ro ([193.231.236.97]:59801 "EHLO smtp.rdslink.ro")
	by vger.kernel.org with ESMTP id S1751400AbWJFRtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:49:17 -0400
X-Mail-Scanner: Scanned by qSheff 1.0 (http://www.enderunix.org/qsheff/)
Date: Fri, 6 Oct 2006 20:49:07 +0300 (EEST)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: ebiederm@xmission.com
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0610062041440.1966@grinch.ro>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006, Linus Torvalds wrote:

>
> Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.
>
> As usual for -rc1 with a lot of pending merges, it's a huge thing with
> tons of changes, and in fact since 2.6.18 took longer than normal due to
> me traveling (and others probably also being on vacations), it's possibly
> even larger than usual.
>
> I think we got updates to pretty much all of the active architectures,
> we've got VM changes (dirty shared page tracking, for example), we've got
> networking, drivers, you name it. Even the shortlog and the diffstats are
> too big to make the kernel mailing list, but even just the summary says
> something:
>
> 4998 total commits
> 6535 files changed, 414890 insertions(+), 233881 deletions(-)
>
> so please give it a good testing, and let's see if there are any
> regressions.
>

In dmesg:
warning: process `sleep' used the removed sysctl system call
warning: process `alsactl' used the removed sysctl system call
warning: process `nscd' used the removed sysctl system call
warning: process `tail' used the removed sysctl system call

ver_linux says:
  /~ $ ./src/kernel/linux-2.6.19-rc1/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux grinch 2.6.19-rc1 #1 PREEMPT Thu Oct 5 22:53:57 EEST 2006 i686 
unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.11
reiserfsprogs          3.6.18
xfsprogs               2.6.13
quota-tools            3.12.
nfs-utils              1.0.7
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1

  /~ $ /usr/sbin/alsactl -v
alsactl version 1.0.10


In Documentation/feature-removal-schedule.txt it says:

---------------------------

What:   sys_sysctl
When:   January 2007
Why:    The same information is available through /proc/sys and that is 
the
         interface user space prefers to use. And there do not appear to be
         any existing user in user space of sys_sysctl.  The additional
         maintenance overhead of keeping a set of binary names gets
         in the way of doing a good job of maintaining this interface.

Who:    Eric Biederman <ebiederm@xmission.com>

---------------------------

I can upgrade my userspace (Slackware 10.1) if necessary ;)

Bye
Calin

--

"frate, trezeste-te, aici nu-i razboiul stelelor"
 				Radu R. pe offtopic at lug.ro

