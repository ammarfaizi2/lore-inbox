Return-Path: <linux-kernel-owner+w=401wt.eu-S1750863AbXAOR4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbXAOR4o (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXAOR4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:56:44 -0500
Received: from ns1.suse.de ([195.135.220.2]:51126 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXAOR4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:56:43 -0500
Date: Mon, 15 Jan 2007 09:56:01 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       icxcnika@mar.tar.cc, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
Message-ID: <20070115175601.GA21679@kroah.com>
References: <200701151210.49495.oliver@neukum.org> <Pine.LNX.4.44L0.0701151058520.15327-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701151058520.15327-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 11:03:35AM -0500, Alan Stern wrote:
> On Mon, 15 Jan 2007, Oliver Neukum wrote:
> 
> > Am Sonntag, 14. Januar 2007 20:47 schrieb icxcnika@mar.tar.cc:
> > > > Can anyone suggest another approach?
> > > >
> > > > Alan Stern
> > > 
> > > Just a thought, you could use both a blacklist approach, and a module 
> > > paramater, or something in sysfs, to allow specifying devices that won't 
> > > be suspend and resume compatible.
> > 
> > Upon further thought, a module parameter won't do as the problem
> > will arise without a driver loaded. A sysfs parameter turns the whole
> > affair into a race condition. Will you set the guard parameter before the
> > autosuspend logic strikes?
> > Unfortunately this leaves only the least attractive solution.
> 
> There could be a mixed approach: a builtin blacklist that is extensible 
> via a procfs- or sysfs-based interface.

Yes, I think this is the best solution, allow users to add their devices
to the kernel through a sysfs interface as a temporary solution, while
providing a built-in list for known broken devices.

And yeah, I hate blacklists too, but they are necessary at times :(

thanks,

greg k-h
