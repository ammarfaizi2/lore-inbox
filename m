Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSACJ5z>; Thu, 3 Jan 2002 04:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285246AbSACJ5p>; Thu, 3 Jan 2002 04:57:45 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:22788 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S285226AbSACJ5d>;
	Thu, 3 Jan 2002 04:57:33 -0500
Date: Wed, 2 Jan 2002 10:26:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20020102102635.A53@toy.ucw.cz>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin> <20011227111415.D12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011227111415.D12868@lynx.no>; from adilger@turbolabs.com on Thu, Dec 27, 2001 at 11:14:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why not just declare ext2_i like the following?  It _should_ work:
> 
> static inline struct ext2_inode_info *ext2_i(const struct inode *inode)
> {
> 	return &(inode->u.ext2_inode_info);
> }
> 
> 
> Minor nit: this is already done for the ext3 code, but it looks like:
> 
> #define EXT3_I	(&((inode)->u.ext3_i))
> 
> We already have the EXT3_SB, so I thought I would be consistent with it:
> 
> #define EXT3_SB	(&((sb)->u.ext3_sb))
> 
> Do people like the inline version better?  Either way, I would like to make
> the ext2 and ext3 codes more similar, rather than less.

Maybe 2.5 is time to merge ext2 and ext3?
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

