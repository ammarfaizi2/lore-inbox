Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287599AbSAHDDz>; Mon, 7 Jan 2002 22:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287598AbSAHDDo>; Mon, 7 Jan 2002 22:03:44 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:63757 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287593AbSAHDDa>;
	Mon, 7 Jan 2002 22:03:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Tue, 8 Jan 2002 04:06:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin> <3C3A1256.BFF12A@mandrakesoft.com>
In-Reply-To: <3C3A1256.BFF12A@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Nmb2-0003Cv-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 10:25 pm, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > The two main problems I see with this are:
> > 
> >   - If a filesystem doesn't want to use genericp_ip/sbp then fs.h has
> >     to know about it.  Why should fs.h know about every filesystem in
> >     the world?
> 
> We keep type information through this method.  There is no ugly casting.

There is a far uglier 1) tying of fs.h to every filesystem in the world 2) a 
gratuitous extra pointer dereference and 3) a pointer field wasted in every 
inode.

In the ugly contest, you win, hands down.

--
Daniel
