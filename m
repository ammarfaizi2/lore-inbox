Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTKMV2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTKMV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:28:32 -0500
Received: from southwark.dsl.net ([65.84.81.9]:663 "EHLO southwark.dsl.net")
	by vger.kernel.org with ESMTP id S264428AbTKMV23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:28:29 -0500
Subject: question about unregister_sysctl_table
From: Karl MacMillan <kmacmillan@tresys.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1068758907.18498.203.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 13 Nov 2003 16:28:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the sysctl interface to export an interface to a modified
version of the Security Enhanced Linux security server and I have some
questions. In a nutshell, I've added conditional expressions to the
SELinux policy language and want to export the booleans used in these
expressions to userspace as entries in a sysctl table.

The problem is that I am trying to add and remove sysctl entries when a
new SELinux policy is loaded and the sysctl implementation doesn't
remove /proc/sys files that are in use or even indicate that they
weren't removed. Should I a) stop trying to use sysctl in this way
because it is an unsupported hack b) modify the sysctl implementation to
remove the files or c) insert your idea here.

Thanks for any help,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134

