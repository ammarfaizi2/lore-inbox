Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRA2XYG>; Mon, 29 Jan 2001 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRA2XX5>; Mon, 29 Jan 2001 18:23:57 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:46600 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S129400AbRA2XXl>;
	Mon, 29 Jan 2001 18:23:41 -0500
Date: Mon, 29 Jan 2001 15:23:35 -0800
From: alex@foogod.com
To: Alan Olsen <alan@clueserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
Message-ID: <20010129152335.H11411@draco.foogod.com>
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com> <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 02:57:44PM -0800, Alan Olsen wrote:
> 
> What is the recommended amount of swap with the 2.4.x kernels?

AFAIK, swap requirements for applications running under a 2.4 kernel have not 
changed significantly from 2.2 kernels (please anyone correct me if I'm wrong),
so the basic answer is:  About as much as you needed with for a 2.2 kernel.

> The standard rule is usually memory x 2.  (But that is more a Solaris
> superstition than anything else.)

This always struck me as the most stupid rule of thumb I'd ever heard of.  
With this metric, systems which precisely need swap the most (low-RAM systems) 
get the least of it, and those that need it the least (those with gigs of RAM) 
get tons of swap they don't need.  I don't know how this keeps perpetuating, 
as it should be plainly brain damaged to anybody who thinks about it for a 
couple of seconds, but somehow it does.

My general recommendation is:
1) Take the best guess you can at how much total memory you're ever going to 
   need at one time.  This can vary with the type of tasks you're doing 
   (server/desktop/image-editing/etc), the software programs you're using, and 
   so on.  There is no easy way to figure this out, but I would recommend that 
   if you come up with anything less than 128MB, you're probably being too 
   optimistic.
2) Subtract the amount of RAM you have (believe it or not, the more RAM you 
   have, the less swap you need.  Imagine that).
3) Round up to a nice breaking point (multiples of 64MB are nice and are easy 
   to remember), just for convenience.
4) Add a little bit of extra just in case (it's better to have too much than 
   too little, particularly since disk is cheap).  I usually add somewhere 
   around 64MB.

For most people, for most systems, this comes out somewhere between 128MB and 
256MB of swap needed (in some cases you may need 512MB or more, but if you've 
got those sorts of memory demands you may want to carefully consider whether 
more RAM wouldn't be a good investment).  If in doubt, go for the larger 
number.  After all, with an 8.1GB drive, how much are you going to miss a puny 
0.25GB (256MB) chunk of it?

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
