Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264691AbSJOWMT>; Tue, 15 Oct 2002 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264775AbSJOWMT>; Tue, 15 Oct 2002 18:12:19 -0400
Received: from ns.suse.de ([213.95.15.193]:28933 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264691AbSJOWMS> convert rfc822-to-8bit;
	Tue, 15 Oct 2002 18:12:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Add extended attributes to ext2/3
Date: Wed, 16 Oct 2002 00:18:11 +0200
User-Agent: KMail/1.4.3
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
References: <200210151640.15581.agruen@suse.de> <20021015220144.GK15552@clusterfs.com> <200210160009.38099.agruen@suse.de>
In-Reply-To: <200210160009.38099.agruen@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210160018.11482.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 00:09, Andreas Gruenbacher wrote:
> > Just as an FYI - marking ext3 inodes dirty is an expensive operation,
> > and should be done only once if at all possible (not sure if the same
> > code applies to ext3 as you are discussing ext2, but I thought I should
> > mention it).
>
> Then I should really think out something to improve that. Thanks.

Can I be sure that it's safe to:
 - move mark_inode_dirty() below unlock_super() in ext2
 - move ext3_mark_inode_dirty() below unlock_super() ext3
in ext[23]_new_inode()?

Thanks.

