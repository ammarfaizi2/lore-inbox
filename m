Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261788AbSJEADl>; Fri, 4 Oct 2002 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261792AbSJEADl>; Fri, 4 Oct 2002 20:03:41 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5392 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261788AbSJEADl>;
	Fri, 4 Oct 2002 20:03:41 -0400
Date: Fri, 4 Oct 2002 17:06:13 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Message-ID: <20021005000613.GE9480@kroah.com>
References: <20021003161320.GA32588@kroah.com> <m17xENj-006iAZC@Mail.ZEDAT.FU-Berlin.DE> <20021003225635.GE2289@kroah.com> <m17xOnh-006hxUC@Mail.ZEDAT.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17xOnh-006hxUC@Mail.ZEDAT.FU-Berlin.DE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 10:07:24AM +0200, Oliver Neukum wrote:
> On Friday 04 October 2002 00:56, Greg KH wrote:
> > On Thu, Oct 03, 2002 at 11:02:36PM +0200, Oliver Neukum wrote:
> > > Perhaps this is a misunderstanding.
> > > You need to report changes of the actual physical medium of eg. a zip
> > > drive. How you want to do this from a class driver, I fail to see.
> >
> > When a "medium" goes away from the system, it is unregistered somehow,
> > right?  So, in the disk class, that device would disappear, and cause
> > the /sbin/hotplug event.
> 
> Well, sadly this is not the case. You can put a medium into a drive and
> pull it out without the kernel ever noticing. Unless of course you try to use
> the thing. But even in this case there's no hotplug event.
> Yet user space and evms have to learn about it in the long term.
> Changing a medium can mean that a new type of medium is inserted.
> A modern zip drive goes from 100M(ro) to 250M(rw) and even 750M(rw)
> We need to know and report.

I agree we need to know this.  And if the kernel figures it out
(somehow) then userspace should also be told about this, through
/sbin/hotplug.  That's all I'm saying.


thanks,

greg k-h
