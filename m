Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285962AbRLHVLq>; Sat, 8 Dec 2001 16:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285961AbRLHVLb>; Sat, 8 Dec 2001 16:11:31 -0500
Received: from stine.vestdata.no ([195.204.68.10]:42203 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S285960AbRLHVLO>; Sat, 8 Dec 2001 16:11:14 -0500
Date: Sat, 8 Dec 2001 22:10:26 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011208221026.H12687@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au> <9useu4$f4o$1@penguin.transmeta.com> <E16ClLY-000124-00@starship.berlin> <3C1277D0.8000706@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1277D0.8000706@namesys.com>; from reiser@namesys.com on Sat, Dec 08, 2001 at 11:28:00PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 11:28:00PM +0300, Hans Reiser wrote:
> Using a union of filesystems, that might not even be compiled into the 
> kernel or as modules, in struct inode is just.....  bad.
> 
> It is really annoying when the filesystems with larger inodes bloat up 
> the size for those who are careful with their bytes, can we do something 
> about that generally?

I believe it has been desided to solve this either by:
* including a filesystem-specific pointer in the general inode
or
* have the filesystem build the inode, and include all the general inode
  variables in it's data-structure.

If it's not alreaddy done in 2.5 I think it's just a question of time.


-- 
Ragnar Kjørstad
Big Storage
