Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285506AbRL2VCP>; Sat, 29 Dec 2001 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285517AbRL2VCF>; Sat, 29 Dec 2001 16:02:05 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53998 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285506AbRL2VBy>;
	Sat, 29 Dec 2001 16:01:54 -0500
Date: Sat, 29 Dec 2001 14:01:05 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20011229140105.A12868@lynx.no>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20011227111415.D12868@lynx.no> <Pine.LNX.4.43.0112290957050.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.43.0112290957050.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 10:04:24AM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 29, 2001  10:04 -0600, Oliver Xymoron wrote:
> On Thu, 27 Dec 2001, Andreas Dilger wrote:
> > Minor nit: this is already done for the ext3 code, but it looks like:
> >
> > #define EXT3_I	(&((inode)->u.ext3_i))
> >
> > We already have the EXT3_SB, so I thought I would be consistent with it:
> >
> > #define EXT3_SB	(&((sb)->u.ext3_sb))
> >
> > Do people like the inline version better?  Either way, I would like to make
> > the ext2 and ext3 codes more similar, rather than less.
> 
> The ext3 macros are rather revolting, simply because they assume the
> variable name. A parameterized macro might be the best compromise:
> 
> #define EXT2_I(i) (&(i->u.ext2_inode_info))

My mistake, the Ext3 macros _do_ take an inode/sb parameter.  It's not that
I'm a huge fan of macros over inline functions, it's just that I would like
to have a consensus about how it should be done so that it is consistent
between ext2 and ext3.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

