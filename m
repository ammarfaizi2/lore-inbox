Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318340AbSHFHV2>; Tue, 6 Aug 2002 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSHFHV2>; Tue, 6 Aug 2002 03:21:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:38153 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318340AbSHFHV1>;
	Tue, 6 Aug 2002 03:21:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208060724.g767Om3178569@saturn.cs.uml.edu>
Subject: Re: BIG files & file systems
To: adilger@clusterfs.com (Andreas Dilger)
Date: Tue, 6 Aug 2002 03:24:48 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), rddunlap@osdl.org (Randy.Dunlap),
       matti.aarnio@zmailer.org (Matti Aarnio),
       hch@infradead.org (Christoph Hellwig),
       braam@clusterfs.com (Peter J. Braam), linux-kernel@vger.kernel.org
In-Reply-To: <20020806051950.GD22933@clusterfs.com> from "Andreas Dilger" at Aug 05, 2002 11:19:50 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:

> I would also have to add another footnote to this, if people start
> talking about limits on 64-bit and >4kB page size systems.  ext2/3 can
> support multiple block sizes (limited by the hardware page size), and
> actually supporting larger block sizes has only been restricted for
> cross-platform compatibility reasons.

This looks pretty silly if you think about it. We support
both 8 kB UFS and 64 kB FAT16 already.

> Having 16kB block size would allow a maximum of 64TB for a single
> filesystem.  The per-file limit would be over 256TB.

Um, yeah, 64 TB of data with 192 TB of holes!
I really don't think you should count a file
that won't fit on your filesystem.

It's one thing to say ext2 is ready for when
the block devices grow. It's another thing to
talk about files that can't possibly fit without
changing the filesystem layout.

> In reality, we will probably implement extent-based allocation for
> ext3 when we start getting into filesystems that large, which has been
> discussed among the ext2/ext3 developers already.

It's nice to have a simple filesystem. If you turn ext2/ext3
into an XFS/JFS competitor, then what is left? Just minix fs?
