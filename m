Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277192AbRJDRZD>; Thu, 4 Oct 2001 13:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277189AbRJDRYx>; Thu, 4 Oct 2001 13:24:53 -0400
Received: from ECE.CMU.EDU ([128.2.136.200]:4555 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S277192AbRJDRYm>;
	Thu, 4 Oct 2001 13:24:42 -0400
Date: Thu, 4 Oct 2001 13:24:55 -0400 (EDT)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Bob Proulx <bob@proulx.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
        Jim Meyering <jim@meyering.net>, viro@math.psu.edu,
        bug-fileutils@gnu.org, Remy.Card@linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <200110040750.f947orU470874@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.3.96L.1011004131850.7119A-100000@hendrix.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Albert D. Cahalan wrote:

> Bob Proulx writes:
> 
> > I tested this on both HP-UX, IBM AIX and Linux.  HP-UX always
> > preserved the previous timestamps.  The same with 2.2.x versions of
> > Linux.  AIX was different and preserved the previous timestamp if
> > the .. entry was the same as before but updated the timestamp if .. was
> > different than before.  But in the case where no real changes occurred
> > none updated the timestamp.  It would be interesting to see what
> > Sun's Solaris and other systems do in those cases.  This does not seem
> > like a huge deal.  There were differences in the different commercial
> > flavors.  But I like to think that we can do better than that.
> 
> Compaq Tru64 5    No time change in any case.
> 

I tested it on Solaris 2.7 . No time stamp change in any of these two
cases ->

mv tmp tmp1
mv tmp ..

In the 1st case there is no justification for time change bcos even the ..
link inside the dir has not changed. In the 2nd case, there may be some
justification but it will lead to a lot of confusion. When there is
nothing to gain and something to lose why make such a change from
traditional behavior ?

thanks
- Nil

