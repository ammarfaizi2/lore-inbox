Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753817AbWKMJRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbWKMJRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbWKMJRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:17:42 -0500
Received: from mail1.panix.com ([166.84.1.72]:39123 "EHLO mail1.panix.com")
	by vger.kernel.org with ESMTP id S1753817AbWKMJRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:17:42 -0500
Message-Id: <20061113064043.264211000@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 12 Nov 2006 22:40:43 -0800
From: Zack Weinberg <zackw@panix.com>
To: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] Syslog permissions, revised
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset revises my attempt from last week to allow running klogd
unprivileged without a root shim.  I believe I have addressed all
outstanding objections: in particular, the privilege model enforced by
SELinux is unchanged (you have to have system__syslog_mod to read
/proc/kmsg).  I have also included some nice refactorings (symbolic
constants for sys_syslog opcodes, that sort of thing) and a few
bugfixes (minor and unlikely to affect any live application, but
still).

I hope that this can be considered for 2.6.19; it is low risk in my
opinion and it would be nice to get this functionality into the hands
of the distributors sooner.

zw


