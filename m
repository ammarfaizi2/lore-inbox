Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHFUru>; Mon, 6 Aug 2001 16:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268563AbRHFUrk>; Mon, 6 Aug 2001 16:47:40 -0400
Received: from weta.f00f.org ([203.167.249.89]:63632 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S267534AbRHFUrT>;
	Mon, 6 Aug 2001 16:47:19 -0400
Date: Tue, 7 Aug 2001 08:48:15 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Chris Mason <mason@suse.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010807084815.A24521@weta.f00f.org>
In-Reply-To: <20010804100143.A17774@weta.f00f.org> <554880000.997110147@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554880000.997110147@tiny>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 11:02:27AM -0400, Chris Mason wrote:

    Aside from the rest of the discussion on this, did you actually trigger
    this BUG for fsync(dir)?  f_op->fsync should already be set to
    reiserfs_dir_fsync.

Yes, but when walking the dentry chain I got to resierfs_file_sync or
something rather than reiserfs_dir_fsync --- two possible fixes,
either have reiserfs internally deal with this (my patch just calls
the dir function from the file function) or try and make the code I
wrote aware of the difference (which technicaly is probably more
correct, I just couldn't figure out how to do it).

I actually made a note to myself to look at merging reiserfs_dir_fsync
and resierfs_file_sync at some point.




  --cw

