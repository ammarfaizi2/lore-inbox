Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRJSVWv>; Fri, 19 Oct 2001 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278661AbRJSVWl>; Fri, 19 Oct 2001 17:22:41 -0400
Received: from [206.162.172.138] ([206.162.172.138]:58104 "EHLO
	remtk.solucorp.qc.ca") by vger.kernel.org with ESMTP
	id <S278660AbRJSVW1>; Fri, 19 Oct 2001 17:22:27 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Fri, 19 Oct 2001 17:23:09 -0500
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Is writing to /dev/ramdom a security flaw (vserver project)
X-mailer: tlmpmail 0.1
Message-ID: <20011019172309.4219c22e9a53@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have announced a project (see my signature) to run several virtual servers
on a single box (single kernel as well). The vservers are real linux distribution
running in a chroot/chbind/chcontext and capability limited environment.

While looking at the kernel we found out that writing to /dev/random is
not controlled by any capability. We are providing a /dev/random in
the vservers with permission 644, so it can be used.

Is this a security issue if an administrator of a vserver is allowed to write
in /dev/random ?

Looking at the source, it seems that it just increase the entropy and should
not be an issue. I am no expert in randomness.

If this is an issue, then a capability must exist to limit that (CAP_SYS_ADMIN
I guess).

Thanks!

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
