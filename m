Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287617AbSAHDZf>; Mon, 7 Jan 2002 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSAHDZP>; Mon, 7 Jan 2002 22:25:15 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:9742 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287619AbSAHDZI>;
	Mon, 7 Jan 2002 22:25:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Tue, 8 Jan 2002 04:28:53 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin> <3C3A33E2.D297F570@mandrakesoft.com>
In-Reply-To: <3C3A33E2.D297F570@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Nmwe-0003D6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 12:48 am, Jeff Garzik wrote:
> > Moving the ext2 headers from include/linux to fs/ext2 is an interesting
> > feature of your patch, though it isn't essential to the idea you're
> > presenting.  But is there a good reason why ext2_fs_i.h and ext2_fs_sb.h
> > should remain separate from ext2_fs.h?  It looks like gratuitous
> > modularity to me.
> 
> apparently userspace includes them, which is the reason for the strange
> types.  good reason to continue to keep them separate.  That's also why
> my patch7 adds an ifdef __KERNEL__.

It's unnecessary for userspace to include those headers, they are 
kernel-private.

--
Daniel
