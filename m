Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbTATQej>; Mon, 20 Jan 2003 11:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTATQej>; Mon, 20 Jan 2003 11:34:39 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:45069 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266218AbTATQej>; Mon, 20 Jan 2003 11:34:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: kernel bug in jfs, kernel 2.4.21-pre3-ac4 + recent listfix (fwd)
Date: Mon, 20 Jan 2003 10:43:30 -0600
User-Agent: KMail/1.4.3
Cc: tupshin@tupshin.com, linux-kernel@vger.kernel.org
References: <200301201605.h0KG5xB11833@shaggy.austin.ibm.com> <200301201026.09479.shaggy@austin.ibm.com> <20030120163521.B32585@infradead.org>
In-Reply-To: <20030120163521.B32585@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301201043.30442.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 January 2003 10:35, Christoph Hellwig wrote:
> On Mon, Jan 20, 2003 at 10:26:09AM -0600, Dave Kleikamp wrote:
> > A recent change to JFS has the resize code determine the volume
> > size from sb->s_bdev->bd_inode->i_size.  However, LVM doesn't
> > update this size when resizing the volume, so JFS doesn't see the
> > new size until the volume is completely unmounted and re-mounted.  
> >  A fix to revert to an earlier behavior that should work is in
> > Marcelo's bk tree and will be available in -pre4.
>
> It doesn't make sense to work around this issue in JFS, LVM needs a
> proper fix so that others don't get beaten by this.

You're probably right.  However, in the 2.4 tree, no other file system 
is using bd_inode->i_size.
-- 
David Kleikamp
IBM Linux Technology Center

