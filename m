Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSIJSjC>; Tue, 10 Sep 2002 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSIJSiz>; Tue, 10 Sep 2002 14:38:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24472 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317978AbSIJSiX>; Tue, 10 Sep 2002 14:38:23 -0400
Date: Tue, 10 Sep 2002 11:42:57 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910114257.A13614@eng2.beaverton.ibm.com>
References: <20020909170847.A24352@eng2.beaverton.ibm.com> <Pine.LNX.4.44.0209101019280.1032-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0209101019280.1032-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Sep 10, 2002 at 10:21:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 10:21:53AM -0700, Patrick Mochel wrote:
> 
> > > > Generic device naming consistency is a problem if multiple devices
> > > > show up with the same id.
> > > 
> > > Patrick Mochel has an open task to come up with a solution to this.
> > 
> > I don't think this can be solved if multiple devices show up with the same
> > id. If I have five disks that all say I'm disk X, how can there be one
> > name or handle for it from user level?
> 
> Easy: you map the unique identifier of the device to a name in userspace.  
> In our utopian future, /sbin/hotplug is called with that unique ID as one
> of its parameters. It searches for, and finds names based on the ID is. If
> the name(s) already exist, then it doesn't continue.
> 
> 
> 	-pat

But then if the md or volume manager wants to do multi-path IO it
will not be able to find all of the names in userspace since the
extra ones (second path and on) have been dropped.

-- Patrick Mansfield
