Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDKSPl (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDKSPl (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:15:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46297 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261493AbTDKSPk (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:15:40 -0400
Date: Fri, 11 Apr 2003 11:12:45 -0700
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411181245.GD1821@kroah.com>
References: <20030411032424.GA3688@kroah.com> <Pine.LNX.4.44.0304111939310.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304111939310.12110-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 08:02:41PM +0200, Roman Zippel wrote:
> On Thu, 10 Apr 2003, Greg KH wrote:
> 
> > I'd like to finally announce the previously vapor-ware udev program that
> > I've talked a lot about with a lot of people over the past months.  The
> > first, very rough cut is at:
> > 	kernel.org/pub/linux/utils/kernel/hotplug/udev-0.1.tar.gz
> 
> Is there a special reason why you call mknod?

I was lazy and trying to get this to work :)

> Otherwise you could simply do:
> 
> 	syscall(SYS_mknod, name, S_IFBLK | mode, dev); 

Yes, I'll switch to this way soon, just have to make sure my version of
dev stays the same size as the kernel's version...

> > Yes, I know there's still a lot of work to do (serialization, symlinks,
> > hooking hotplug so that others can also use it, etc.) but it's a first
> > step :)
> 
> To help serialization and perfomance issues, it might help to add a daemon 
> mode to hotplug. The kernel calls hotplug with a pipe from which it reads 
> the event data, after a certain timeout it can close the pipe and exit.

Yes, this is probably what is going to happen soon.

thanks,

greg k-h
