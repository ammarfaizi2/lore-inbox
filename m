Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTJ2XAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJ2XAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:00:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:42898 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261959AbTJ2XAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:00:03 -0500
Date: Wed, 29 Oct 2003 14:59:22 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing kobject release methods?
Message-ID: <20031029225922.GB1513@kroah.com>
References: <Pine.LNX.4.44L0.0310271121350.679-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0310271121350.679-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 11:31:44AM -0500, Alan Stern wrote:
> Greg:
> 
> For a long time, I've been getting debug warnings about missing release()  
> methods in various kobjects.  They come up because your usb-2.5 tree has
> DEBUG defined in a number of driver-model source files.

And because I have a "test for .release in a kobject" patch in my tree
to help me debug.  That's what you are seeing.

> It's not easy to track down exactly what the objects in question are;

Don't worry about these, they are all for things that are only
directories, and don't have release functions because they do not need
to at this time.  Pat is aware of these and someday we will divorce
kobjects from beeing needed just to create a subdirectory in sysfs.

These false warnings are the reason that patch never made it into the
main kernel tree, unlike the other .release checks in the driver model
code.

You can just disable that change in your copy of my tree if it's really
annoying you :)

thanks,

greg k-h
