Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWIAVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWIAVcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWIAVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:32:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:23217 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750918AbWIAVcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:32:51 -0400
Message-Id: <20060901221421.968954146@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Sat, 02 Sep 2006 00:14:21 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
Subject: [patch 0/2] Tmpfs acls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refresh of the patches we have to support POSIX ACLs on tmpfs,
with the request for inclusion.

The patches solve the following problem: We want to grant access to
devices based on who is logged in from where, etc. This includes
switching back and forth between multiple user sessions, etc.

Using ACLs to define device access for logged-in users gives us all the
flexibility we need in order to fully solve the problem.

Device special files nowadays usually live on tmpfs, hence tmpfs ACLs.

Different distros have come up with solutions that solve the problem to
different degrees: SUSE uses a resource manager which tracks login
sessions and sets ACLs on device inodes as appropriate. RedHat uses
pam_console, which changes the primary file ownership to the logged-in
user. Others use a set of groups that users must be in in order to be
granted the appropriate accesses.

The freedesktop.org project plans to implement a combination of a
console-tracker and a HAL-device-list based solution to grant access to
devices to users, and more distros will likely follow this approach.

-

These patches have first been posted here on 2 February 2005, and again
on 8 January 2006. We have been shipping them in SLES9 and SLES10 with
no problems reported.  The previous submission is archived here:

   http://lkml.org/lkml/2006/1/8/229
   http://lkml.org/lkml/2006/1/8/230
   http://lkml.org/lkml/2006/1/8/231

Could the patches please get included this time?

Andrew, is putting them in -mm for a while fine with you?

Thanks,
Andreas

--
Andreas Gruenbacher <agruen@suse.de>
Novell / SUSE Labs

-- 
VGER BF report: U 0.5
