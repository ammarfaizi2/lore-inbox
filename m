Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSIJTcz>; Tue, 10 Sep 2002 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSIJTcy>; Tue, 10 Sep 2002 15:32:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2730 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318058AbSIJTcx>;
	Tue, 10 Sep 2002 15:32:53 -0400
Date: Tue, 10 Sep 2002 12:37:32 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910123732.A15175@eng2.beaverton.ibm.com>
References: <20020910114257.A13614@eng2.beaverton.ibm.com> <Pine.LNX.4.44.0209101145550.1032-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0209101145550.1032-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Sep 10, 2002 at 12:00:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 12:00:47PM -0700, Patrick Mochel wrote:
> 
> On Tue, 10 Sep 2002, Patrick Mansfield wrote:
> 
> > On Tue, Sep 10, 2002 at 10:21:53AM -0700, Patrick Mochel wrote:
> > > Easy: you map the unique identifier of the device to a name in userspace.  
> > > In our utopian future, /sbin/hotplug is called with that unique ID as one
> > > of its parameters. It searches for, and finds names based on the ID is. If
> > > the name(s) already exist, then it doesn't continue.
> > > 
> > > 
> > > 	-pat
> > 
> > But then if the md or volume manager wants to do multi-path IO it
> > will not be able to find all of the names in userspace since the
> > extra ones (second path and on) have been dropped.
> 
> Which is it that you want? One canonical name or all the paths? I supplied
> a solution for the former in my repsonse. The latter is solved via the
> exposure of the paths in driverfs, which has been discussed previously.
> 
> 
> 	-pat

For scsi multi-path, one name; without scsi multi-path (or for individual
paths that are not exposed in driverfs) each path probably needs to show up
in user space with a different name so md or other volume managers can use
them.

-- Patrick Mansfield
