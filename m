Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWEJQBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWEJQBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWEJQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:01:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63400 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964786AbWEJQBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:36 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/14] Permit filesystem local caching and NFS superblock sharing  [try #8]
Date: Wed, 10 May 2006 17:01:11 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches make it possible to share NFS superblocks between related
mounts, where "related" means on the same server and FSID. Inodes and dentries
will be shared where the NFS filehandles are the same (for example if two NFS3
files come from the same export but from different mounts, such as is not
uncommon with autofs on /home).

These patches also add local caching for network filesystems such as NFS and
AFS.

The first six patches (NFS superblock sharing) can be applied without the
remaining patches (filesystem local caching).

David
