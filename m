Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUCKWZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCKWZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:25:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:10690 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261787AbUCKWZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:25:27 -0500
Date: Thu, 11 Mar 2004 14:25:15 -0800
From: Mark Wong <markw@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-lvm@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lvm2 performance data with linux-2.6
Message-ID: <20040311142515.A27177@osdlab.pdx.osdl.net>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>, linux-lvm@redhat.com,
	linux-kernel@vger.kernel.org
References: <200403081916.i28JGgE25794@mail.osdl.org> <4050E453.3010809@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4050E453.3010809@tmr.com>; from davidsen@tmr.com on Thu, Mar 11, 2004 at 05:12:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 05:12:35PM -0500, Bill Davidsen wrote:
> markw@osdl.org wrote:
> > I've started collecting various data (including oprofile) using our
> > DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
> > ia64 platforms:
> > 	http://developer.osdl.org/markw/lvm2/
> > 
> > So far I've only varied the stripe width with lvm, from 8 KB to 512 KB,
> > for PostgreSQL that is using 8 KB sized blocks with ext2.  It appears
> > that a stripe width of 16 KB through 128KB on the ia64 system gives the
> > best throughput for the DBT-2 workload on a volume that should be doing
> > mostly sequential writes.
> > 
> > I'm going to run through more tests varying the block size that
> > PostgreSQL uses, but I wanted to share what I had so far in case there
> > were other suggestions or recommendations.
> > 
> Here's one thought: look at the i/o rates on individual drives using 
> each stripe size. You *might* see that one size does far fewer seeks 
> than others, which is a secondary thing to optimize after throughput IMHO.
> 
> If you don't have a tool for this I can send you the latest diorate 
> which does stuff like this, io rate perdrive or per partition, something 
> I occasionally find revealing.

Yeah, please do send me a copy.  I'd be interested to see what that might 
turn up.  I've just been using iostat -x so far.

Thanks,
Mark
