Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263398AbSJFMUh>; Sun, 6 Oct 2002 08:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbSJFMUh>; Sun, 6 Oct 2002 08:20:37 -0400
Received: from dp.samba.org ([66.70.73.150]:42696 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263398AbSJFMUe>;
	Sun, 6 Oct 2002 08:20:34 -0400
Date: Sun, 6 Oct 2002 22:24:22 +1000
From: Anton Blanchard <anton@samba.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: 2.5.40: raid0_make_request bug and bad: scheduling while atomic!
Message-ID: <20021006122422.GH22888@krispykreme>
References: <anf7nq$qp2$1@ncc1701.cistron.net> <3DA01C81.D2BDD8C7@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA01C81.D2BDD8C7@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The workaround is to force BIO's to be no bigger than a page.
> That limits performance, but it should still be somewhat better
> than the pre-bio times.
> 
> This used to be fixable in mpage.c, where a comment
> explained what to to in precense of "braindead drivers"
> But mpage.c changed sometime between 2.5.36 and 2.5.39.
> 
> Now the new include/linux/bio.h has the following:
> #define BIO_MAX_PAGES           (256)
> I tried substituting (1) for (256), but it didn't help.
> So I don't mount raid-0 right now.

Peter Chubb mailed a fix for this to linux-kernel in the last week
and I can confirm it fixes all my raid0 problems. Thanks Peter!

http://marc.theaimsgroup.com/?l=linux-kernel&m=103369952814053&w=2

Anton
