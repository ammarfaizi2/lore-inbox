Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVKSELg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVKSELg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKSELg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:11:36 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:25077
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750881AbVKSELf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:11:35 -0500
Date: Fri, 18 Nov 2005 21:11:30 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 0/12: eCryptfs] eCryptfs version 0.1
Message-ID: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up set of patches in response to comments made after
our first submission to the LKML at the beginning of this month. We
were able to track down and resolve several bugs, and we feel that
eCryptfs is now ready to be merged into the -mm tree as an
experimental filesystem.

We have successfully run a series of tests, including FSX,
Connectathon, and Bonnie. In addition, we are able to successfully
compile the Linux kernel under eCryptfs, both with and without
multiple threads on a multi-processor PPC64 machine.

We are able to invoke a bug that terminates a process when we stress
the filesystem with multiple concurrent operations (FSX, multiple
Connectathon jobs, and a kernel compile running simultaneously), but
we cannot oops the kernel with any of our test cases.

eCryptfs utilizes David Howells' keyring; at mount, eCryptfs version
0.1 expects an existing authentication token in the user's session
keyring. The tarball containing the code to do this is available from
the eCryptfs SourceForge site:

http://sourceforge.net/projects/ecryptfs/

Several features demonstrated in prototypes of eCryptfs at OLS in the
past have been left out of this release until they can be thoroughly
tested; the reduced complexity of this patch set should make it easier
to evaluate for initial inclusion into the Linux kernel. Future
updates will provide policy support, which will entail per-file
passphrase and per-file public key support.

Thanks,
Phillip
