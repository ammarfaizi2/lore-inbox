Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287440AbSAGXwr>; Mon, 7 Jan 2002 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSAGXwj>; Mon, 7 Jan 2002 18:52:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287407AbSAGXwY>;
	Mon, 7 Jan 2002 18:52:24 -0500
Message-ID: <3C3A34B0.C59D11CB@mandrakesoft.com>
Date: Mon, 07 Jan 2002 18:52:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 7/7 v2] Re: PATCH 2.5.2.9: ext2 unbork fs.h 
 (part 1/7)
In-Reply-To: <Pine.GSO.4.21.0201071401450.6842-100000@weyl.math.psu.edu> <3C3A2F0E.4A132214@mandrakesoft.com> <20020107164921.J777@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jan 07, 2002  18:28 -0500, Jeff Garzik wrote:
> > --- linux-fs6/fs/ext2/ext2_fs_i.h     Mon Sep 17 20:16:30 2001
> > +++ linux-fs7/fs/ext2/ext2_fs_i.h     Mon Jan  7 05:08:38 2002
> > @@ -36,6 +36,10 @@
> >       __u32   i_prealloc_count;
> >       __u32   i_dir_start_lookup;
> >       int     i_new_inode:1;  /* Is a freshly allocated inode */
> > +
> > +#ifdef __KERNEL__
> > +     struct inode i_inode_data;
> > +#endif
> >  };
> 
> Since ext2_fs_i.h only describes the in-memory data for ext2 inodes, there
> is no reason to #ifdef __KERNEL__ any changes therein.  I have seen several
> other people worry about changes to this file in the past also, and I was
> going to suggest adding a comment to the file, but I see it already says
> "inode data in memory" so I don't know what else to add...

If that is ok with everyone else, it's ok with me.  I just noticed that
ext2_fs_sb.h already uses kernel-specific types, adding weight to the
argument.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
