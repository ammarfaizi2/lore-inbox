Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135818AbRDTGb0>; Fri, 20 Apr 2001 02:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRDTGbQ>; Fri, 20 Apr 2001 02:31:16 -0400
Received: from THINK.THUNK.ORG ([216.175.175.162]:24071 "EHLO think.thunk.org")
	by vger.kernel.org with ESMTP id <S135818AbRDTGbG>;
	Fri, 20 Apr 2001 02:31:06 -0400
Date: Fri, 20 Apr 2001 02:30:52 -0400
From: Theodore Tso <tytso@valinux.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: tytso@valinux.com, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
Message-ID: <20010420023052.C5417@think>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolinux.com>,
	Ext2 development mailing list <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20001202014045.F2272@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu> <20010419161003.E17837@snap.thunk.org> <3ADF4AC0.2485C0BC@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ADF4AC0.2485C0BC@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 04:29:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 04:29:52PM -0400, Jeff Garzik wrote:
> tytso@valinux.com wrote:
> > In the long run, it probably makes sense to adjust the algorithms to
> > allow for non-power-of-two inode sizes,
> 
> If you don't mind, does that imply packing inodes across block
> boundaries?

No, it means that padding the end of each block in the inode table so
that inodes don't cross block boundries.  (i.e., if the inode size is
150 bytes, then there's room for 6 inodes in a 1k block, with 124
bytes left over for padding.)

						- Ted
