Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRAPUgt>; Tue, 16 Jan 2001 15:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132025AbRAPUgj>; Tue, 16 Jan 2001 15:36:39 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:19982 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S132120AbRAPUgb>; Tue, 16 Jan 2001 15:36:31 -0500
Date: Tue, 16 Jan 2001 15:37:57 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Dominik Kubla'" <dominik.kubla@uni-mainz.de>,
        "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116153757.A1609@munchkin.spectacle-pond.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Tue, Jan 16, 2001 at 12:01:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 12:01:12PM -0800, Dr. Kelsey Hudson wrote:
> On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:
> 
> > > This is due to the fixed ordering of the scsi drivers. You can change the
> > > order of the scsi hosts with the "scsihosts" kernel parameter. See
> > > linux/drivers/scsi/scsi.c
> > 	[Venkatesh Ramamurthy]  I think it would be a nice idea if we can
> > make this process automatic , with out user typing in the order and
> > remembering it. The fact that a kernel developer is not using the machines
> > daily to get his work done should be in our minds. If we do this Linux would
> > become more user friendly
> 
> you're forgetting that in /etc/lilo.conf there is a directive called
> 'append='... all the user has to do is merely add
> 'append="scsihosts=whatever,whatever"' into their config file and rerun
> lilo. problem solved

That's assuming you are using lilo.  Not everybody does or can use lilo, please
don't assume that the way your system gets booted is the way everybody's does,
particularly those on platforms other than the x86.

I must say, as a 5 year Linux user (and 23 year UNIX user/administrator), I do
get tired of having to hunt down and deal with each of these changes that come
up from time to time with Linux (ie, switching from ipfwadm to ipchains to
netfilter, or in this case reordering how scsi adapters/network adapters are
looked up).

> besides, how many 'end-users' do you know of that will have multiple scsi
> adapters in one system? how many end-users -period- will have even a
> *single* scsi adapter in their systems? do we need to bloat the kernel
> with automatic things like this? no... i think it is handled fine the way
> it is. if the user wants to add more than one scsi adapter into his
> system, let him read some documentation on how to do so. (is this even a
> documented feature? if not, i think it should be added to the docs...)

I'm an end-user, and I have 3 scsi-adapters of two different brands in my
system.  Many of the people using Linux in high end things like servers,
etc. will have multiple scsi controlers.  People are using Linux in lots of
things from small embedded devices to large systems, and Linux needs to address
needs in every area.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
