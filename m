Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287325AbSACSCO>; Thu, 3 Jan 2002 13:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284837AbSACSCF>; Thu, 3 Jan 2002 13:02:05 -0500
Received: from dsl-213-023-043-223.arcor-ip.net ([213.23.43.223]:53262 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287325AbSACSBy>;
	Thu, 3 Jan 2002 13:01:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@ns.caldera.de>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Thu, 3 Jan 2002 19:04:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201031139410.23312-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201031139410.23312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MCEb-00019E-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 05:45 pm, Alexander Viro wrote:
> On Thu, 3 Jan 2002, Christoph Hellwig wrote:
> 
> > In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > > -	inode = get_empty_inode();
> > > +	inode = get_empty_inode(sb);
> > 
> > How about killing get_empty_inode completly and using new_inode() instead?
> > There should be no regularly allocated inode without a superblock.
> 
> Seconded.  However, you'll need to zero out ->i_dev for objects that
> traditionally have zero ->st_dev (pipes and sockets).

If you spell out exactly what special case treatment you'd like for i_dev, 
I'll make the changes to get rid of get_empty_inode.

--
Daniel
