Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269716AbRHIHcR>; Thu, 9 Aug 2001 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRHIHcI>; Thu, 9 Aug 2001 03:32:08 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:35744 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S269716AbRHIHbz>; Thu, 9 Aug 2001 03:31:55 -0400
Date: Thu, 9 Aug 2001 10:31:44 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: =?iso-8859-1?Q?Samuli_K=E4rkk=E4inen?= <skarkkai@woods.iki.fi>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, phillips@nl.linux.org
Subject: Re: Wrong free inodes count in kernels 2.0 and 2.2
Message-ID: <20010809103144.B63773@niksula.cs.hut.fi>
In-Reply-To: <20010502194621.D22433@woods.iki.fi> <20010809010601.A63773@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010809010601.A63773@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Aug 09, 2001 at 01:06:01AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 01:06:01AM +0300, you [Ville Herva] claimed:
> On Wed, May 02, 2001 at 07:46:21PM +0300, [Samuli Kärkkäinen] claimed:
> > I get repeatably both in 2.0 and 2.2 serieses of kernels the following kind
> > of errors:
> > 
> > 2.2 kernels (several, including 2.2.18):
> >   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 768, stored = 984, counted = 717
> >   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 769, stored = 1005, counted = 717
> >   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 777, stored = 998, counted = 901
> >   [ many similar lines deleted ]
> > 
> > and sometimes with 2.2 kernel, soon after the errors above:
> >   EXT2-fs error (device ide1(22,1)): ext2_new_inode: Free inodes count corrupted in group 414 
> >   last message repeated 795 times
> 
> I get these messages as well on 2.2.18pre19:
> 
> EXT2-fs error (device md(9,0)): ext2_new_inode: Free inodes count
> corrupted in group 501                                                                  
> EXT2-fs error (device md(9,0)): ext2_new_inode: Free inodes count
> corrupted in group 501                                                                  

I was just wondering, could this be the same bug Daniel Phillips described
in thread "[PATCH] Re: 2.4.0-test11 ext2 fs corruption":

http://groups.google.com/groups?q=2.4.0-test11+ext2+fs+corruption+group:mlist.linux.kernel&hl=en&safe=off&scoring=r&rnum=1&selm=linux.kernel.news2mail-3A259959.89EAD4DE%40innominate.de
http://groups.google.com/groups?hl=en&safe=off&th=cbe5e86866187b4,4&rnum=1&selm=linux.kernel.Pine.GSO.4.21.0011301652130.21891-100000%40weyl.math.psu.edu

and that was fixed in 2.4.0-test time?

A google search shows a number of people are seeing this error so it would be
nice to get the fix for 2.2 (and even 2.0), too...

http://www.google.com/search?q=ext2_new_inode%3A+Free+inodes+count+corrupted+in+group&sourceid=opera&num=0


-- v --

v@iki.fi
