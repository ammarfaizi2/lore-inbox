Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWG2GGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWG2GGD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 02:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWG2GGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 02:06:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422636AbWG2GGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 02:06:00 -0400
Date: Fri, 28 Jul 2006 23:05:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Permit filesystem local caching and NFS
 superblock sharing  [try #11]
Message-Id: <20060728230540.7358b435.akpm@osdl.org>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 21:52:22 +0100
David Howells <dhowells@redhat.com> wrote:

> These patches make it possible to share NFS superblocks between related
> mounts, where "related" means on the same server and FSID. Inodes and dentries
> will be shared where the NFS filehandles are the same (for example if two NFS3
> files come from the same export but from different mounts, such as is not
> uncommon with autofs on /home).

It's not clear why these were sent.  The first 25 patches are, as far as I
can tell, already in Trond's tree.  Whether Trond has the correct versions
of these is now anybody's guess...

"[PATCH 26/30] NFS: Use local caching" appears to be the first patch which
isn't in Trond's tree, but it doesn't work due to significant changes in
nfs_clear_inode().

