Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262270AbRERHzg>; Fri, 18 May 2001 03:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262271AbRERHz0>; Fri, 18 May 2001 03:55:26 -0400
Received: from 21dyn73.com21.casema.net ([213.17.91.73]:20490 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262270AbRERHzR>; Fri, 18 May 2001 03:55:17 -0400
Message-Id: <200105180755.JAA23039@cave.bitwizard.nl>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
 from Linus Torvalds at "May 14, 2001 09:43:18 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 18 May 2001 09:55:14 +0200 (MEST)
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'm really serious about doing "resume from disk". If you want a fast
> boot, I will bet you a dollar that you cannot do it faster than by loading
> a contiguous image of several megabytes contiguously into memory. There is
> NO overhead, you're pretty much guaranteed platter speeds, and there are
> no issues about trying to order accesses etc. There are also no issues
> about messing up any run-time data structures.

Linus, 

The "boot quickly" was an example. "Load netscape quickly" on some
systems is done by dd-ing the binary to /dev/null. 

Now, you're going to say again that this won't work because of
buffer-cache/page-cache incoherency.  That is NOT the point. The point
is that the fun about a cache is that it's just a cache. It speeds
things up transparently. 

If I need a new "prime-the-cache" program to mmap the files, and
trigger a page-in in the right order, then that's fine with me.

The fun about doing these tricks is that it works, and keeps on
working (functionally) even if it stops working (fast).

Yes, there is a way to boot even faster: preloading memory. Fine. But
this doesn't allow me to load netscape quicker.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
