Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281499AbRKMF1d>; Tue, 13 Nov 2001 00:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281513AbRKMF1Z>; Tue, 13 Nov 2001 00:27:25 -0500
Received: from ns.suse.de ([213.95.15.193]:57102 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281494AbRKMF1O>;
	Tue, 13 Nov 2001 00:27:14 -0500
Date: Tue, 13 Nov 2001 06:27:11 +0100
From: Andi Kleen <ak@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Gruenbacher <ag@bestbits.at>, Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011113062711.A1912@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Nov 12, 2001 at 07:32:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 07:32:18PM -0500, Alexander Viro wrote:
> Which means that converting permission() to vfsmount/dentry should be
> done first.  And that's not hard to do.

It's just messy as it will require changes in all file systems.

> Sorry, folks, but idea of private extendable syscall table (per-filesystem,
> no less) doesn't look like a good thing.  That's _the_ reason why ioctl()
> is bad.

Unless I'm badly misreading the patch the op switch() is fixed in VFS mapping
to clearly defined inode operations. It is not extensible per filesystem.
Arguably they could be split into individual syscalls, but it looks not more 
like cosmetics at this point.

-Andi

