Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVLSTJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVLSTJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLSTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:09:10 -0500
Received: from digitalimplant.org ([64.62.235.95]:10120 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932360AbVLSTJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:09:09 -0500
Date: Mon, 19 Dec 2005 11:08:54 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Greg KH <greg@kroah.com>, "" <linux-kernel@vger.kernel.org>,
       "" <viro@ftp.linux.org.uk>
Subject: Re: [RFC] Updates to sysfs_create_subdir()
In-Reply-To: <20051205062439.GA4123@in.ibm.com>
Message-ID: <Pine.LNX.4.50.0512191105540.6447-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net>
 <20051128204950.GC17740@kroah.com> <Pine.LNX.4.50.0511300759170.28582-100000@monsoon.he.net>
 <20051205062439.GA4123@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Dec 2005, Maneesh Soni wrote:

>
> (cc-ing Al for his views)
>
> On Wed, Nov 30, 2005 at 09:05:41AM -0800, Patrick Mochel wrote:
> >
> > On Mon, 28 Nov 2005, Greg KH wrote:
> >
> > > On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
> > > >
> > > > The patch below addresses this issue by parsing the subdirectory name and
> > > > creating any parent directories delineated by a '/'.
> > >
>
> well, creating directory hierarchy for attributes in one shot could be
> useful in some cases, but is it worth putting more fuel to race conditions
> in sysfs? I am afraid that there could be extra efforts also needed for
> userspace to manage the namespace collisions in sysfs.

Yeah, after more thought, it doesn't seem necessary, nor worth it to spend
the time ironing out all of the details.

> Nested attributes will not be straight forward. With this scheme do all
> attributes in the attrbiute tree belong to same kobject?

Yes, they would all belong to the same kobject, which means they would all
have to go away when the kobject did, which could get hairy, especially
when kobjects are added/removed in rapid succession.

I think the best approach is to scrap this idea and to leverage other
existing infrastructure better..

Thanks for the commentary, and sorry about the delay in responding,


	Patrick

