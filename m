Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266785AbUFYQUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUFYQUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUFYQUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:20:24 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:38365 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S266785AbUFYQUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:20:21 -0400
Date: Fri, 25 Jun 2004 12:20:16 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware - memory problem?
Message-ID: <20040625162016.GD16916@washoe.rutgers.edu>
Mail-Followup-To: Helge Hafting <helge.hafting@hist.no>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu> <20040624215856.GA728@washoe.rutgers.edu> <20040625000102.GI728@washoe.rutgers.edu> <40DBE853.4050707@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DBE853.4050707@hist.no>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He hey - you're the boss!!!! 
It helped - 'mem=512M' made the beast fast :-)

Now we just will mangle with /proc/mtrr :-)

THANX AGAIN!

Sincerely
Yarik

On Fri, Jun 25, 2004 at 10:54:43AM +0200, Helge Hafting wrote:
> Yaroslav Halchenko wrote:

> >because slow down seems to be linked to memory: brk(0) takes on average
> >0.5-1.5 second, I've decided to run silly memtest...
> >I have around 1GB total on that beast, I turned off swap and did memtest
> >1G


> Memory.  Could it be the good old MTRR problem?
> Try "cat /proc/mtrr" and check that _all_ ordinary memory
> is covered by a write-back mtrr.

> Having most of the memory covered lacking a little at the top only
> is not good enough - you'll see a major slowdown as linux tend to
> use the topmost memory most and that will be very slow without
> a MTRR.

> If it indeed is a mtrr problem, confirm it by booting with mem=<low number>
> and see that the machine is faster when not using the "slow" memory.
> After that, get a bios upgrade or echo something useable
> into /proc/mtrr

> Helge Hafting

-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

