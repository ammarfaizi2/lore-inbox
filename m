Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJCW57>; Thu, 3 Oct 2002 18:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJCW57>; Thu, 3 Oct 2002 18:57:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46989 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261438AbSJCW56>;
	Thu, 3 Oct 2002 18:57:58 -0400
Date: Thu, 3 Oct 2002 19:03:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Greg KH <greg@kroah.com>
cc: Oliver Neukum <oliver@neukum.name>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
In-Reply-To: <20021003225635.GE2289@kroah.com>
Message-ID: <Pine.GSO.4.21.0210031859370.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Greg KH wrote:

> On Thu, Oct 03, 2002 at 11:02:36PM +0200, Oliver Neukum wrote:
> > Perhaps this is a misunderstanding.
> > You need to report changes of the actual physical medium of eg. a zip drive.
> > How you want to do this from a class driver, I fail to see.
> 
> When a "medium" goes away from the system, it is unregistered somehow,
> right?  So, in the disk class, that device would disappear, and cause
> the /sbin/hotplug event.
> 
> This is assuming that we can detect media changes, which is a whole
> different topic that I don't want to get involved with :)

Our mechanism is retroactive.  We can (kinda-sorta) tell "did the
media change happen since the last time we'd asked".  That's it.
And even that is less than accurate - many drivers decide to be on
the safe side and _always_ answer "yes, it did".

And yes, it sucks.

