Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbTATQ0m>; Mon, 20 Jan 2003 11:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTATQ0m>; Mon, 20 Jan 2003 11:26:42 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:3856 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266256AbTATQ0l>; Mon, 20 Jan 2003 11:26:41 -0500
Date: Mon, 20 Jan 2003 16:35:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: tupshin@tupshin.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bug in jfs, kernel 2.4.21-pre3-ac4 + recent listfix (fwd)
Message-ID: <20030120163521.B32585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>, tupshin@tupshin.com,
	linux-kernel@vger.kernel.org
References: <200301201605.h0KG5xB11833@shaggy.austin.ibm.com> <200301201026.09479.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301201026.09479.shaggy@austin.ibm.com>; from shaggy@austin.ibm.com on Mon, Jan 20, 2003 at 10:26:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 10:26:09AM -0600, Dave Kleikamp wrote:
> A recent change to JFS has the resize code determine the volume size 
> from sb->s_bdev->bd_inode->i_size.  However, LVM doesn't update this 
> size when resizing the volume, so JFS doesn't see the new size until 
> the volume is completely unmounted and re-mounted.    A fix to revert 
> to an earlier behavior that should work is in Marcelo's bk tree and 
> will be available in -pre4.

It doesn't make sense to work around this issue in JFS, LVM needs a
proper fix so that others don't get beaten by this.

