Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVKVK2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVKVK2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKVK2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:28:33 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:38115 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932241AbVKVK2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:28:32 -0500
Date: Tue, 22 Nov 2005 11:28:12 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>,
       Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122102812.GA11630@wohnheim.fh-wedel.de>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051122075148.GB20476@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051122075148.GB20476@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 November 2005 07:51:48 +0000, Christoph Hellwig wrote:
> 
> > o 128 bit
> >   On 32bit machines, you can't even fully utilize a 64bit filesystem
> >   without VFS changes.  Have you ever noticed?  Thought so.
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

...once the need arises.  Even with byte addressing, 64 bit are enough
to handle roughly 46116860 of the biggest hard disks currently
available.  Looks like we still have a bit of time to think about the
problem before action is required.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
