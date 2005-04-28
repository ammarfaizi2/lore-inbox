Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVD1FFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVD1FFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD1FFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:05:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:20928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261981AbVD1FEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:04:30 -0400
Date: Wed, 27 Apr 2005 22:03:46 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Device Node Issues with recent mm's and udev
Message-ID: <20050428050346.GB10182@kroah.com>
References: <d4757e6005042716523af66bae@mail.gmail.com> <20050428041428.GB9723@kroah.com> <d4757e6005042721577ba48cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e6005042721577ba48cc@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:57:46AM -0400, Joe wrote:
> On 4/28/05, Greg KH <greg@kroah.com> wrote:
> > Is the device "disappearing" and then the udev deletes the device node,
> > and then dd starts dumping data to a file instead?
> > 
> > Anything in your kernel log when this happens?
> > 
> > Does this happen with 2.6.12-rc3?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> I've checked the kernel logs and was unable to find anything
> suspicious.  This does not seem to happen on vanilla, its a mm only
> issue.
> 
> The device becomes a regular file, and udev seems to forget about it..

That implies that udev got a hotplug event that told it to delete the
node.

Any kernel log entries?  Is the device in usb or firewire mode?

> even if I replug in the device, udev will not touch this file.

That's because the file is not a node, and udev will not overwrite that.

> It also seems to have trouble recreating the node even when the file
> has been deleted

"trouble" how?

thanks,

greg k-h
