Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSAHAQT>; Mon, 7 Jan 2002 19:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSAHAQJ>; Mon, 7 Jan 2002 19:16:09 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:37876 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287450AbSAHAPx>;
	Mon, 7 Jan 2002 19:15:53 -0500
Date: Mon, 7 Jan 2002 17:15:00 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-ID: <20020107171500.L777@lynx.no>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin> <3C3A33E2.D297F570@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3A33E2.D297F570@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jan 07, 2002 at 06:48:50PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2002  18:48 -0500, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > Moving the ext2 headers from include/linux to fs/ext2 is an interesting
> > feature of your patch, though it isn't essential to the idea you're
> > presenting.  But is there a good reason why ext2_fs_i.h and ext2_fs_sb.h
> > should remain separate from ext2_fs.h?  It looks like gratuitous
> > modularity to me.
> 
> apparently userspace includes them, which is the reason for the strange
> types.  good reason to continue to keep them separate.  That's also why
> my patch7 adds an ifdef __KERNEL__.

Could you be more specific?  AFAIK, the ext2_fs.h file is also used by
e2fsprogs (which actually has its own, _more_ up-to-date version of this
file), but the _i.h and _sb.h files are for kernel use only.  They do not
have any relation to on-disk ext2 structs, so there would not really be
any point in referencing them from userspace.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

