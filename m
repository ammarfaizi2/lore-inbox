Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUCKXDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCKXDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:03:10 -0500
Received: from mailgate2.Cadence.COM ([158.140.2.31]:14585 "EHLO
	mailgate2.Cadence.COM") by vger.kernel.org with ESMTP
	id S261819AbUCKXBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:01:47 -0500
Subject: Re: [linux-lvm] Re: lvm2 performance data with linux-2.6
From: Chris Croswhite <csc@cadence.com>
Reply-To: csc@cadence.com
To: linux-lvm@redhat.com
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040311142515.A27177@osdlab.pdx.osdl.net>
References: <200403081916.i28JGgE25794@mail.osdl.org>
	 <4050E453.3010809@tmr.com>  <20040311142515.A27177@osdlab.pdx.osdl.net>
Content-Type: text/plain
Organization: Cadence Design Systems, Inc
Message-Id: <1079046114.3850.349.camel@d158140025182.Cadence.COM>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 15:01:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this generally available to all?  Where can it be had?

TIA

On Thu, 2004-03-11 at 14:25, Mark Wong wrote:
> On Thu, Mar 11, 2004 at 05:12:35PM -0500, Bill Davidsen wrote:
> > markw@osdl.org wrote:
> > > I've started collecting various data (including oprofile) using our
> > > DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
> > > ia64 platforms:
> > > 	http://developer.osdl.org/markw/lvm2/
> > > 
> > > So far I've only varied the stripe width with lvm, from 8 KB to 512 KB,
> > > for PostgreSQL that is using 8 KB sized blocks with ext2.  It appears
> > > that a stripe width of 16 KB through 128KB on the ia64 system gives the
> > > best throughput for the DBT-2 workload on a volume that should be doing
> > > mostly sequential writes.
> > > 
> > > I'm going to run through more tests varying the block size that
> > > PostgreSQL uses, but I wanted to share what I had so far in case there
> > > were other suggestions or recommendations.
> > > 
> > Here's one thought: look at the i/o rates on individual drives using 
> > each stripe size. You *might* see that one size does far fewer seeks 
> > than others, which is a secondary thing to optimize after throughput IMHO.
> > 
> > If you don't have a tool for this I can send you the latest diorate 
> > which does stuff like this, io rate perdrive or per partition, something 
> > I occasionally find revealing.
> 
> Yeah, please do send me a copy.  I'd be interested to see what that might 
> turn up.  I've just been using iostat -x so far.
> 
> Thanks,
> Mark
> 
> _______________________________________________
> linux-lvm mailing list
> linux-lvm@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-lvm
> read the LVM HOW-TO at http://tldp.org/HOWTO/LVM-HOWTO/

