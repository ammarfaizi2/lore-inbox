Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWAFTEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWAFTEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAFTEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:04:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932461AbWAFTEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:04:33 -0500
Date: Fri, 6 Jan 2006 14:04:29 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601061904.k06J4T3r027891@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] updated *at function patch
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry about the previous mails, I've bad problems with my connection
and need to resort to doing this remotely with very high latency.]

Just a little update and relative to the current sources.

The only code change are three lines of code: renaming fchmod to fchmodat,
adding a new parameter, passing it to __user_walk_fd, and a new one-line
wrapper function sys_chmod.  The other changes are hooking up the syscall
and the previously not-hooked-up faccessat syscal.
