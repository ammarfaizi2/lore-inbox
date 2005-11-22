Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVKVOvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVKVOvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVKVOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:51:15 -0500
Received: from thunk.org ([69.25.196.29]:38125 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964952AbVKVOvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:51:14 -0500
Date: Tue, 22 Nov 2005 09:50:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122145047.GB29179@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
	linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051122075148.GB20476@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122075148.GB20476@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:51:48AM +0000, Christoph Hellwig wrote:
> 
> What is a '128 bit' or '64 bit' filesystem anyway?  This description doesn't
> make any sense,  as there are many different things that can be
> addresses in filesystems, and those can be addressed in different ways.
> I guess from the marketing documents that they do 128 bit _byte_ addressing
> for diskspace.  All the interesting Linux filesystems do _block_ addressing
> though, and 64bits addressing large enough blocks is quite huge.
> 128bit inodes again is something could couldn't easily implement, it would
> mean a non-scalar ino_t type which guarantees to break userspace.  128
> i_size?  Again that would totally break userspace because it expects off_t
> to be a scalar, so every single file must fit into 64bit _byte_ addressing.
> If the surrounding enviroment changes (e.g. we get a 128bit scalar type
> on 64bit architectures) that could change pretty easily, similarly to how
> ext2 got a 64bit i_size during the 2.3.x LFS work.

I will note though that there are people who are asking for 64-bit
inode numbers on 32-bit platforms, since 2**32 inodes are not enough
for certain distributed/clustered filesystems.  And this is something
we don't yet support today, and probably will need to think about much
sooner than 128-bit filesystems....


						- Ted
