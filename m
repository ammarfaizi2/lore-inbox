Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUBSUxc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267267AbUBSUxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:53:32 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:22508 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S267573AbUBSUua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:50:30 -0500
Date: Thu, 19 Feb 2004 12:48:21 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: sysconf - exposing constants to userspace
Message-ID: <20040219204820.GC9155@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the preferred way to expose "constants" to userland?  I quoty-finger
"constants" because they may be defined as constants to any given kernel,
they are not necessarily constant over time.

There are things which can be changed as constants which would currently
require a libc recompile.  For example NGROUPS_MAX :).  Since it just got
merged, anyone who wants to use it will have to recompile their libc to get
the new value of NGROUPS_MAX.

I found an old old patch to do this via read-only sysctl() entries.  Should
I resurrect that patch?  Or maybe just do a sys_sysconf() entry?  Or should
I just shut up and tell users to cope with recompiling libc?

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
