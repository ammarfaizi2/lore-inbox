Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSIJS4W>; Tue, 10 Sep 2002 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSIJS4V>; Tue, 10 Sep 2002 14:56:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38019 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318018AbSIJS4U>;
	Tue, 10 Sep 2002 14:56:20 -0400
Date: Tue, 10 Sep 2002 12:00:47 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Lars Marowsky-Bree <lmb@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
In-Reply-To: <20020910114257.A13614@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0209101145550.1032-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Sep 2002, Patrick Mansfield wrote:

> On Tue, Sep 10, 2002 at 10:21:53AM -0700, Patrick Mochel wrote:
> > 
> > > > > Generic device naming consistency is a problem if multiple devices
> > > > > show up with the same id.
> > > > 
> > > > Patrick Mochel has an open task to come up with a solution to this.
> > > 
> > > I don't think this can be solved if multiple devices show up with the same
> > > id. If I have five disks that all say I'm disk X, how can there be one
> > > name or handle for it from user level?
> > 
> > Easy: you map the unique identifier of the device to a name in userspace.  
> > In our utopian future, /sbin/hotplug is called with that unique ID as one
> > of its parameters. It searches for, and finds names based on the ID is. If
> > the name(s) already exist, then it doesn't continue.
> > 
> > 
> > 	-pat
> 
> But then if the md or volume manager wants to do multi-path IO it
> will not be able to find all of the names in userspace since the
> extra ones (second path and on) have been dropped.

Which is it that you want? One canonical name or all the paths? I supplied
a solution for the former in my repsonse. The latter is solved via the
exposure of the paths in driverfs, which has been discussed previously.


	-pat

