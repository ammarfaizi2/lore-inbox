Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUCaAf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUCaAf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:35:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:57813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262532AbUCaAfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:35:23 -0500
Date: Tue, 30 Mar 2004 16:34:47 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       maneesh@in.ibm.com, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040331003447.GC10262@kroah.com>
References: <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org> <406A0C15.7090506@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406A0C15.7090506@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 04:08:53PM -0800, David Brownell wrote:
> Alan Stern wrote:
> 
> >	  I'm in favor of changing the behavior of sysfs, so that either it
> >refuses to delete directories that contain subdirectories or else it
> >recursively deletes the subdirectories first.  At this point nothing has
> >been settled.
> 
> Hmm, certainly I agree khubd should be deleting things bottom-up.
> 
> Are you say it isn't doing that already?  Or that it's trying to,
> but something's preventing that from working?

Look at everything that hangs off of usb devices in the sysfs tree that
the usb core knows nothing about (scsi hosts, tty devices, etc.)

Anyway, it's working properly now, and is why I added that kobject
parent patch a long time ago (which Alan still seems to think is
incorrect...)

thanks,

greg k-h
