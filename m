Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbTDKXXo (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbTDKXWX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:22:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30680 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262478AbTDKXVa (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:21:30 -0400
Date: Fri, 11 Apr 2003 16:35:07 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: sdake@mvista.com, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411233507.GC4539@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411150933.43fd9a84.akpm@digeo.com> <20030411230111.GF3786@kroah.com> <20030411162338.4b16b8f7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411162338.4b16b8f7.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:23:38PM -0700, Andrew Morton wrote:
> > 
> > But how many events to we buffer?
> 
> On a large machine: 856,432.

Heh.

> > When do we start to throw them away?
> > Fun policy decisions that we don't have to worry about in the current
> > scheme.
> 
> The current scheme will run out of processes, kernel stacks, etc before a
> message scheme would.
> 
> > Also, what's the format of the kernel->user interface.
> 
> Exactly the same as at present, with /sbin/hotplug chopped off.  So you can
> run the daemon:
> 
> 	while read x
> 	do
> 		/sbin/hotplug $x
> 	done < /dev/hotplug_event_pipe
> 
> for compatibility with existing scripts.

But the current interface is a single argument, and whole lot of
variable length environment variables that may or may not be set,
depending on the argument.  That would be a mess to parse from a single
stream (not undoable, but painful).

thanks,

greg k-h
