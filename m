Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317818AbSFSLB0>; Wed, 19 Jun 2002 07:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSFSLBZ>; Wed, 19 Jun 2002 07:01:25 -0400
Received: from ns.suse.de ([213.95.15.193]:29711 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317818AbSFSLBZ>;
	Wed, 19 Jun 2002 07:01:25 -0400
Date: Wed, 19 Jun 2002 13:01:26 +0200
From: Dave Jones <davej@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt cause series of oopses in 2.5.22 and 2.5.22-dj1
Message-ID: <20020619130126.J25509@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <3D10613C.CB30F5D3@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D10613C.CB30F5D3@aitel.hist.no>; from helgehaf@aitel.hist.no on Wed, Jun 19, 2002 at 12:47:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 12:47:24PM +0200, Helge Hafting wrote:
 > The oopses scrolling by all starts with
 > init[454] exited with preempt-count xx
 > where xx increase by 3 for each oops.  
 > The call trace is longer each time.
 > The scrolling stops when this counter reach 63 or 66, 
 > probably running out of some resource such as kernel stack.

As I wrote to you offlist a week or two ago, I've tried tracking
this down, but found no real fix. I've a box here that doesn't
like preempt at all, but it's only my tree that the oops seems
to show up in. 

Robert Love and myself stared at the (minimal) backtrace that
it caused a week or two ago and got nowhere. The only solution
I found so far was to disable preempt on that box.

If you can rig this box up to a serial terminal and capture
the first oops and decode it, it'll be interesting to see if
we're hitting the same bug (Which I suspect we are, the symptoms
sound identical).

I'll investigate some more when I get time.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
