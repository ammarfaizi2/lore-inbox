Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSIJRRX>; Tue, 10 Sep 2002 13:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSIJRRX>; Tue, 10 Sep 2002 13:17:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41858 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317434AbSIJRRV>;
	Tue, 10 Sep 2002 13:17:21 -0400
Date: Tue, 10 Sep 2002 10:21:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Lars Marowsky-Bree <lmb@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
In-Reply-To: <20020909170847.A24352@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0209101019280.1032-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Generic device naming consistency is a problem if multiple devices
> > > show up with the same id.
> > 
> > Patrick Mochel has an open task to come up with a solution to this.
> 
> I don't think this can be solved if multiple devices show up with the same
> id. If I have five disks that all say I'm disk X, how can there be one
> name or handle for it from user level?

Easy: you map the unique identifier of the device to a name in userspace.  
In our utopian future, /sbin/hotplug is called with that unique ID as one
of its parameters. It searches for, and finds names based on the ID is. If
the name(s) already exist, then it doesn't continue.


	-pat

