Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288249AbSACQqT>; Thu, 3 Jan 2002 11:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSACQqE>; Thu, 3 Jan 2002 11:46:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60075 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288241AbSACQpQ>;
	Thu, 3 Jan 2002 11:45:16 -0500
Date: Thu, 3 Jan 2002 11:45:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Daniel Phillips <phillips@bonn-fries.net>, acme@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
In-Reply-To: <200201031545.g03Fjtj11546@ns.caldera.de>
Message-ID: <Pine.GSO.4.21.0201031139410.23312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Christoph Hellwig wrote:

> In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > -	inode = get_empty_inode();
> > +	inode = get_empty_inode(sb);
> 
> How about killing get_empty_inode completly and using new_inode() instead?
> There should be no regularly allocated inode without a superblock.

Seconded.  However, you'll need to zero out ->i_dev for objects that
traditionally have zero ->st_dev (pipes and sockets).

