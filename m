Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269676AbRHCXIp>; Fri, 3 Aug 2001 19:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269675AbRHCXIe>; Fri, 3 Aug 2001 19:08:34 -0400
Received: from weta.f00f.org ([203.167.249.89]:4496 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269669AbRHCXIQ>;
	Fri, 3 Aug 2001 19:08:16 -0400
Date: Sat, 4 Aug 2001 11:09:05 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804110905.B17925@weta.f00f.org>
In-Reply-To: <20010804100143.A17774@weta.f00f.org> <Pine.GSO.4.21.0108031840090.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031840090.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:45:47PM -0400, Alexander Viro wrote:

    nfs_fsync().

Ah, well... then I'm not sure how the loop should look.  I use
f->fsync(file, dentry, ...) where file references the original file
not any of the parent path components.

Obviously, for ext2 and reiserfs (which is what I have here) this
won't matter --- will it for NFS?  If so, so I need to open/etc. for
each parent component to get a valid struct file*?

Please bear with me, I'm still learning :)



  --cw
