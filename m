Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNWO4>; Thu, 14 Dec 2000 17:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNWOr>; Thu, 14 Dec 2000 17:14:47 -0500
Received: from smtp.networkusa.net ([216.15.144.12]:16752 "EHLO
	smtp.networkusa.net") by vger.kernel.org with ESMTP
	id <S129260AbQLNWOf>; Thu, 14 Dec 2000 17:14:35 -0500
Date: Thu, 14 Dec 2000 15:44:01 -0600
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ORBit speed measure
Message-ID: <20001214154400.B3804@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012141100590.26708-100000@www.nondot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <Pine.LNX.4.21.0012141100590.26708-100000@www.nondot.org>; from sabre@nondot.org on Thu, Dec 14, 2000 at 11:10:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 11:10:24AM -0600, Chris Lattner wrote:
> There are many other optimizations that one can make the transport faster
> that ORBit doesn't implement.  For example, you could mmap (shared) data
> buffers between the two processes communicating (of course, you still need
> to wake processes up, which is why it hasn't been done yet), or you could

This is not necessarily faster.

I recently came across some discussions on the web from Jim Gettys that
discussed similar issues for X (unix sockets vs shared memory).  I seem to
remember that the over head of synchronizing stuff to keep the shared
memory in a sane state ate away at any gains one had with using shared
memory.  It works ok for large chunks of data (say, things on the order of
sizes of pixmaps), but not for smaller pieces, like say, function call
arguments.

Then again, isn't Jim some how involved in ORBit and GNOME?  Or just a big
supporter?  :->

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
