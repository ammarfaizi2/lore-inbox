Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291267AbSBMAWQ>; Tue, 12 Feb 2002 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291268AbSBMAWH>; Tue, 12 Feb 2002 19:22:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8966 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291267AbSBMAV6>;
	Tue, 12 Feb 2002 19:21:58 -0500
Message-ID: <3C69B165.4301DD9A@zip.com.au>
Date: Tue, 12 Feb 2002 16:20:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ext2 synchronous mount speedup
In-Reply-To: <3C69A174.B092D044@zip.com.au>,
		<3C69A174.B092D044@zip.com.au>; from akpm@zip.com.au on Tue, Feb 12, 2002 at 03:12:52PM -0800 <20020212170313.V9826@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Feb 12, 2002  15:12 -0800, Andrew Morton wrote:
> > --- linux-2.4.18-pre9/include/linux/ext2_fs_i.h       Mon Sep 17 13:16:30 2001
> > +++ linux-akpm/include/linux/ext2_fs_i.h      Tue Feb 12 14:00:11 2002
> > @@ -25,7 +25,6 @@ struct ext2_inode_info {
> >       __u32   i_faddr;
> >       __u8    i_frag_no;
> >       __u8    i_frag_size;
> > -     __u16   i_osync;
> >       __u32   i_file_acl;
> >       __u32   i_dir_acl;
> >       __u32   i_dtime;
> 
> We should probably leave this in there as a placeholder (with a different
> name), just for alignment sake.
> 

hrm.   I'd assumed the compiler would get that right.
Otherwise, the __u8's go to the end of the struct.

-
