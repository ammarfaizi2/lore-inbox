Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135661AbRDTGiG>; Fri, 20 Apr 2001 02:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135821AbRDTGh4>; Fri, 20 Apr 2001 02:37:56 -0400
Received: from THINK.THUNK.ORG ([216.175.175.162]:26631 "EHLO think.thunk.org")
	by vger.kernel.org with ESMTP id <S135661AbRDTGhu>;
	Fri, 20 Apr 2001 02:37:50 -0400
Date: Fri, 20 Apr 2001 02:37:39 -0400
From: Theodore Tso <tytso@valinux.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Alexander Viro <viro@math.psu.edu>, tytso@valinux.com,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
Message-ID: <20010420023739.E5417@think>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Andreas Dilger <adilger@turbolinux.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Ext2 development mailing list <ext2-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0104192213060.19860-100000@weyl.math.psu.edu> <200104200535.f3K5Ze82017093@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104200535.f3K5Ze82017093@webber.adilger.int>; from adilger@turbolinux.com on Thu, Apr 19, 2001 at 11:35:40PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:35:40PM -0600, Andreas Dilger wrote:
> I don't _think_ that there is a requirement for a multiple-of-8 inodes
> per group.  OK, looking into mke2fs (actually lib/ext2fs/initialize.c)
> it _does_ show that it needs to be a multiple of 8, but I'm not sure
> exactly what the "bitmap splicing code" mentioned in the comment is.

It's has to be a multiple of 8 because of how e2fsprogs handles
bitmaps --- that is, it takes the various pieces of all of the
bitmaps, and butts them up together in memory.  It would be possible
to remove this restriction by reworking the e2fsprogs library code,
but quite frankly, I don't think the restriction is all that
unreasonable.

						- Ted
