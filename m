Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTDKRI2 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDKRI2 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:08:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29659 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261362AbTDKRIM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:08:12 -0400
Date: Fri, 11 Apr 2003 10:20:11 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411172011.GA1821@kroah.com>
References: <20030411032424.GA3688@kroah.com> <200304110837.37545.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304110837.37545.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 08:37:37AM +0200, Oliver Neukum wrote:
> 
> > Anyway, this works for me, on my machines, and I am very interested in
> > feedback from everyone about both this concept, and the implementation
> > of this.  I've cced a lot of different lists, as they have all expressed
> > interest in this project.
> 
> Cool, an utterly new piece of code to play with.
> Well, it has some nice issues.
> 
> - There's a race with replugging, which you can do little about

True, but this can get smaller.

> - Error handling. What do you do if the invocation ends in EIO ?

Which invocation?  From /sbin/hotplug?

> - Performance. What happens if you plug in 4000 disks at once?

You crash your power supply :)

Seriously, the kernel spawns 4000 instances of /sbin/hotplug just like
it always does.  I'm working on keeping udev from spawning anything else
to keep the process cound down (right now it fork/execs for mknod, but
that was just me being lazy.)

thanks,

greg k-h
