Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVFBFqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFBFqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 01:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFBFqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 01:46:55 -0400
Received: from c-24-10-129-155.hsd1.ut.comcast.net ([24.10.129.155]:50120 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S261579AbVFBFqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 01:46:37 -0400
Date: Wed, 1 Jun 2005 23:47:40 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602054740.GA4514@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first in a series of 3 patches for the eCryptfs kernel
module.

eCryptfs is a cryptographic filesystem that stacks on top of other
filesystems.  A very early version of it was presented last year at
OLS, and the current version will be presented again at this year's
OLS.  It is currently in an EXPERIMENTAL and BROKEN state (i.e., it
will build and run, but there is at least one memory leak that causes
a problem when a several dozen file open/read/write operations are
performed).  It requires userspace components to run, which can be
obtained via CVS from the eCryptfs project site:

http://sourceforge.net/projects/ecryptfs

The README file from CVS explains how to get it up and running with
both passphrase and public key (PKI) operation modes.

While eCryptfs is functional, there is a significant amount of work
yet to be done; a perusal of the source will reveal that there is a
lot of low-hanging fruit/trivial fixes (David Howells: we promise that
using your keyring correctly is near the top of the list, right after
we get these memory leaks resolved).  It derives from cryptfs, which
is a cryptographic filesystem instantiated by Erez Zadok's stackable
filesystem framework, FiST.  We are aware that there are some extant
bugs in the version of cryptfs that we built off of; as those are made
known, we will be applying fixes.  In the meantime, we would like the
eCryptfs kernel module to be merged into the mainline kernel.  We are
open to suggestions and commentary on the general design of the
filesystem, and bugfixes are always welcome too.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

This first patch is somewhat large (45K), so here is a link:

http://ecryptfs.sourceforge.net/patches/patch-2.6.12-rc4-mm2-ecryptfs-1_of_3.diff.gz

-- 
Phillip Hellewell <phillip AT hellewell.homeip.net>
