Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSGZX0V>; Fri, 26 Jul 2002 19:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318644AbSGZX0V>; Fri, 26 Jul 2002 19:26:21 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:2061 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318643AbSGZX0T>;
	Fri, 26 Jul 2002 19:26:19 -0400
Date: Fri, 26 Jul 2002 16:28:58 -0700
From: Greg KH <greg@kroah.com>
To: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020726232858.GB24008@kroah.com>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu> <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 28 Jun 2002 22:09:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 06:54:11PM +0200, Kurt Garloff wrote:
> Hi Al,
> 
> On Fri, Jul 26, 2002 at 12:45:41PM -0400, Alexander Viro wrote:
> > On Fri, 26 Jul 2002, Kurt Garloff wrote:
> > > The patches are all available at
> > > http://www.suse.de/~garloff/linux/scsi-many/
> > 
> > As long as you realize that it won't go in 2.5 in that form...
> 
> The sd parts can and should be ported to 2.5, I think.
> The /proc/scsi/scsi extensions and other stuff I wrote to support it, 
> won't be needed, as we have driverfs in 2.5.
> And, of course, the device number management will be solved in a more
> general way, but I do not yet see how. 

Why that's quite simple (with apologies to South Park) :
	1) finish the driver model code and banish devfs to a corner of
	the kernel where it will not do any harm.
	2) {silence}
	3) Purely dynamic major and minors now work.

:)

It will happen, eventually.  Most of us are busy laying the groundwork
right now...

thanks,

greg k-h
