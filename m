Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUAHAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUAHAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:42:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:40577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262784AbUAHAmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:42:07 -0500
Date: Wed, 7 Jan 2004 16:41:24 -0800
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040108004124.GA3388@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com> <14870000.1073521945@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14870000.1073521945@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:32:26PM -0800, Martin J. Bligh wrote:
> >> NOTE! We do have an alternative: if we were to just make block device 
> >> nodes support "readdir" and "lookup", you could just do
> >> 
> >> 	open("/dev/sda/1" ...)
> >> 
> >> and it magically works right. I've wanted to do this for a long time, but 
> >> every time I suggest allowing it, people scream.
> > 
> > Hm, that would be nice.  I don't remember seeing it being proposed
> > before, what are the main complaints people have with this?
> 
> Couldn't the partitions go under "/dev/sdaX/{1,2,3}" and solve the same
> problem without doing magic on the devices?

No, that's not the point.  As discussed on irc, I think you now
understand the issue (partitions not being present, media changed
without kernel knowing about it, etc.)

thanks,

greg k-h
