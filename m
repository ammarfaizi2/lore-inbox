Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOWR3>; Thu, 15 Feb 2001 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOWRK>; Thu, 15 Feb 2001 17:17:10 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:44248 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129066AbRBOWRF>; Thu, 15 Feb 2001 17:17:05 -0500
Message-ID: <3A8C554A.8E4D7E76@uow.edu.au>
Date: Thu, 15 Feb 2001 22:16:42 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@sonic.net>
CC: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com> <3A8A8937.A77BA18D@uow.edu.au> <20010214093859.B20503@sonic.net> <3A8AC6B6.9790FF9C@colorfullife.com> <3A8BC242.2C62DAA1@uow.edu.au>,
		<3A8BC242.2C62DAA1@uow.edu.au>; from Andrew Morton on Thu, Feb 15, 2001 at 10:49:22PM +1100 <20010215090807.C29356@sonic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:
> 
> On Thu, Feb 15, 2001 at 10:49:22PM +1100, Andrew Morton wrote:
> >
> > Now, the thing I don't understand about David's design is the
> > final one.  What 3c575_cb does is:
> >
> > CONFIG_HOTPLUG=y, MODULE=true
> >          If the hardware isn't there, register the driver and
> >          hang around.
> >
> > Why?
> 
> Merely that I was trying to disassociate the concepts of module
> loading and device probing, and I thought it was most consistent to
> then allow people to load modules whenever they want, whether or not a
> device was present.

Fair enough.  Thanks.

Another scenario may be where (say) a network driver is modprobed
from a hotpluggable disk controller.  You want to be able to load
the netdriver, pop out the disk controller and then insert the network
card.  Or vice-versa - load a parallel port driver across NFS then
pull the network card and push the parallel port card.  Could use
local disks for this, of course.

hmm..
