Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOUht>; Fri, 15 Dec 2000 15:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLOUhj>; Fri, 15 Dec 2000 15:37:39 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13572 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129183AbQLOUha>;
	Fri, 15 Dec 2000 15:37:30 -0500
Message-ID: <20001215193217.A3960@bug.ucw.cz>
Date: Fri, 15 Dec 2000 19:32:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Feuer <David_Feuer@brown.edu>, linux-kernel@vger.kernel.org
Subject: Re: swapoff weird
In-Reply-To: <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu> <20001209222427.A1542@bug.ucw.cz> <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu> <20001210015623.V6567@cadcamlab.org> <4.3.2.7.2.20001210040635.00b63340@postoffice.brown.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4.3.2.7.2.20001210040635.00b63340@postoffice.brown.edu>; from David Feuer on Sun, Dec 10, 2000 at 04:10:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >[David Feuer]
> > > Perhaps it would be good to put a check in unlink to make sure that
> > > this is not the last link to a swapfile.
> >
> >Much better to add code to /sbin/swapon and /sbin/swapoff to set and
> >clear immutable bit.  Sure it only works on ext2 but how far do you
> >want to take this thing?
> 
> In a private email, linux@horizon.com  wrote:
> 
> >No; we should add some more magic-symlink /proc entries, like
> >/proc/<pid>/fd/<n> for swap files.  Then they can be accessed
> >by swapoff even if they're deleted.
> 
> Seems like a good idea to me...

We could make them opened by kswapd.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
