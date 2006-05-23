Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWEWQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWEWQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWEWQ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:56:06 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44520 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750753AbWEWQ4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:56:05 -0400
Subject: [Question] how to follow a symlink via a dentry?
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 23 May 2006 12:56:03 -0400
Message-Id: <1148403363.22855.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the best way from inside the kernel, to find the dentry that
another dentry points to via symlink?

Scenario:

I have a kobj of a device in the sysfs system.  Inside a directory of
the kobj, is a symlink to another device I need to get.  I can find the
dentry of the symlink, but I haven't found a good way to get to the
dentry of what the symlink points to.

Is there a standard way to do this, or do I need to start hacking at the
follow_link of the sysfs directory to get what I want?

Do I need to hack up something like page_readlink to get the path, and
then do vfs_follow_link to get the rest.  Another thing is that I can't
rely on what current->fs points to.

Thanks,

-- Steve


