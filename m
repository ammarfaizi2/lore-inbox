Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbULMUO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbULMUO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULMUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:14:43 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:52707 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261330AbULMUN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:13:56 -0500
Subject: Re: 2.6.10-rc3-mm1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
References: <20041213020319.661b1ad9.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102968515.27895.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Dec 2004 15:08:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 05:03, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
<snip>
> selinux-adds-a-private-inode-operation.patch
>   selinux: adds a private inode operation
> 
> reiserfs-private-inode-abstracted-to-static-inline.patch
>   reiserfs: private inode abstracted to static inline
> 
> reiserfs-fixes-to-allow-reiserfs-to-use-selinux-attributes.patch
>   reiserfs: fixes to allow reiserfs to use selinux attributes
> 
> reiserfs-cleaning-up-const-checks.patch
>   reiserfs: cleaning up const checks
> 
> selinux-hooks-cleanup.patch
>   SELinux: hooks cleanup
<snip>

These patches are obsoleted by the new patchset by Jeff Mahoney that
adds a S_PRIVATE flag to i_flags, changes reiserfs to use this flag,
changes the security framework to not call the security modules on such
private inodes, and makes one change to SELinux to deal with its
handling of inodes allocated prior to initial policy load and superblock
security setup.  So I believe that you can drop all of these patches.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

