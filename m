Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbSJCQPv>; Thu, 3 Oct 2002 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJCQPv>; Thu, 3 Oct 2002 12:15:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33522 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261681AbSJCQPu>;
	Thu, 3 Oct 2002 12:15:50 -0400
Date: Thu, 3 Oct 2002 12:21:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Greg KH <greg@kroah.com>
cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <20021003161320.GA32588@kroah.com>
Message-ID: <Pine.GSO.4.21.0210031217430.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Greg KH wrote:

> > Umm...  OK.  There were some plans to add a notifier chain for such events
> > and EVMS looks like a possible user of that beast.  However, it's not
> > obvious whether we need to do any of that in the kernel - we definitely
> > can have userland up and running before _any_ block devices are initialized,
> > so it might be a work for userland helper.
> 
> /sbin/hotplug already gets called for _every_ device that is added to
> the system as of 2.5.40, so you should probably use that as your
> userspace notifier event.  If there's anything that the /sbin/hotplug
> call misses, that you need for evms, please let me know.

We need it
	a) early enough
	b) called for things like umem, etc. - random drivers built into
the tree and exporting several block devices.

