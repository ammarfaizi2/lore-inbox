Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTJRWz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJRWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:55:28 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:54280 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261881AbTJRWz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:55:27 -0400
Date: Sat, 18 Oct 2003 15:55:21 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031018225521.GA3699@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net> <3F903768.7060803@rackable.com> <yw1xllrjk70f.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xllrjk70f.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 09:18:24PM +0200, Måns Rullgård wrote:
> Samuel Flory <sflory@rackable.com> writes:
> 
> >> What about the RAID controllers in the $400 category?  Surely, they
> >> must be doing something better than the $50 fakeraid controllers.
> >>
> >
> >    Yes, but follow this logic.
> >
> > 1)You are willing to devote 10% of 2Ghz xeon to software raid.
> > 2)A $500+ controller has a 100Mhz proccessor.
> >
> >    Thus just from this you could guess that software raid has x2 as
> >    many clock cycles availble to it.  It's even worse when you realize
> >    the 2Ghz xeon is a better proccessor in many more ways than just
> >    clock cycles.
> 
> How about this logic:
> 
> 1) If the processor on the RAID controller can handle the full
> bandwidth of the disks, it's fast enough.
> 2) If someone else does the 10% work, the CPU can do 10% more work.

And as has been addressed on this list before:

3) If the additional I/O traffic of the RAID can be kept off
of the system busses the overall system throughput goes up.

Once the CPU reaches a certain level of performance it is
the I/O and memory that limit things.  Do you really want to
pollute L1 cache with RAID-5?  When the $400 RAID server
card can saturate the PCI buss it doesn't matter how much
spare CPU you have, SW RAID will not be able to match the
performance.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
