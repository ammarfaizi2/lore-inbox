Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269679AbRHCXUE>; Fri, 3 Aug 2001 19:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269685AbRHCXTy>; Fri, 3 Aug 2001 19:19:54 -0400
Received: from weta.f00f.org ([203.167.249.89]:7312 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269679AbRHCXTi>;
	Fri, 3 Aug 2001 19:19:38 -0400
Date: Sat, 4 Aug 2001 11:20:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804112026.D17925@weta.f00f.org>
In-Reply-To: <20010804110905.B17925@weta.f00f.org> <Pine.GSO.4.21.0108031911230.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031911230.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 07:15:59PM -0400, Alexander Viro wrote:

    <shrug> credentials cache. 2.5 fodder. Notice that with NFS you
    don't have fsync for directories. At all. So that's not a problem
    in that particular case - you can pass NULL on all subsequent
    iterations.  On the first step you need struct file * - NFS needs
    credentials to pass to the server.

How about passing NULL then for now? --- and explicitly requiring
->fsync accept NULL for the first argument and ignore it?  It would be
nice to know that this is the case then though, because we could stop
immediately.



  --cw

