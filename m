Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312854AbSDKXKy>; Thu, 11 Apr 2002 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSDKXKx>; Thu, 11 Apr 2002 19:10:53 -0400
Received: from imladris.infradead.org ([194.205.184.45]:1287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312854AbSDKXKw>; Thu, 11 Apr 2002 19:10:52 -0400
Date: Fri, 12 Apr 2002 00:10:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020412001002.A29540@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com> <Pine.GSO.4.21.0204111629370.21089-100000@weyl.math.psu.edu> <3CB5FFB5.693E7755@zip.com.au> <20020411225536.GE8062@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 04:55:36PM -0600, Andreas Dilger wrote:
> At one time Linus proposed having an array of dirty bits for a page,
> which would allow us to mark only parts of a page dirty (say down to
> the sector level).  I believe this was in the discussion about moving
> the block devices to the page cache around 2.4.10.

The early XFS code used to do this for kiobuf-based block I/O, but it
got dropped around 2.4.8 IIRC.  The new page->private handling from akpm
which seems to be merged in Linus' BK tree (Linus: please push it to
bkbits.net, thanks :)) can be used to do the same if and only if we don't
need the buffer_heads attached to the page.

