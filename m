Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUHWSSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUHWSSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUHWSSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:18:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266273AbUHWSOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:14:14 -0400
Date: Mon, 23 Aug 2004 14:14:05 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][0/7] xattr consolidation and support for ramfs & tmpfs
Message-ID: <Xine.LNX.4.44.0408231408030.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches consolidates some common xattr logic into libfs,
saving significant code duplication and making it easier for filesystem
writers to implement xattr support.

The ext3, ext2 and devpts filesytems are then converted to use the new
API, and xattr support is added to ramfs and tmpfs.

Three related LSM hooks are changed to take inodes instead of dentries, 
which is in keeping with the existing ext2 and ext3 code (the existing 
devpts code wants to pass a dentry, but it doesn't need to).

I've done a fair bit of testing of these patches with no problems.  Please 
review and apply if ok.


- James
-- 
James Morris
<jmorris@redhat.com>



