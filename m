Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284516AbRLUJae>; Fri, 21 Dec 2001 04:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284522AbRLUJaY>; Fri, 21 Dec 2001 04:30:24 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:10682 "EHLO outside")
	by vger.kernel.org with ESMTP id <S284516AbRLUJaQ>;
	Fri, 21 Dec 2001 04:30:16 -0500
Date: Fri, 21 Dec 2001 09:59:11 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: rbector@andiamo.com
Cc: lkcd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: LKCD (kernel core dumps) - network dumps
Message-ID: <20011221095911.A1296@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajeev,

Network dumping (especially for the kind of situations you are referring 
to) is something on our wishlist too.  Dave Howell from Intel has been 
looking into this for a blade server type environments. As you've
rightly observed there are some issues to do with the state of the system
at the time of dumping.

One of the things that Matt and some of us from the lkcd development 
community are working on for a future release of lkcd, is a dump driver 
interface which the generic dump code would call into to write out the 
dump (rather than rely on the normal i/o paths the way it does today). 
So far we've mostly been focussing on disk devices, but we did want to make
sure we cover network dumping requirements as well.

I'm cc'ing this mail to lkcd development list, which is where most of 
our discussions take place.

Regards
Suparna

  Suparna Bhattacharya
  Linux Technology Center
  IBM Software Lab, India
  E-mail : bsuparna@in.ibm.com
  Phone :  91-80-5044961
-----------------------------------------------------
List:     linux-kernel
Subject:  LKCD (kernel core dumps)
From:     "Rajeev Bector" <rbector@andiamo.com>
Date:     2001-12-20 21:12:15
[Download message RAW]

Has anybody worked on a system to transfer the kernel dump
out to a server once we hit panic (as opposed to dumping
it to disk). This will obviously not work if IP itself is
corrupted. This can be useful in embedded systems where
the local disk is not big enough to store the dump or there
is no disk ?

Does this even make sense to do something like this ?

Thanks for your replies.

Rajeev


----- End forwarded message -----
