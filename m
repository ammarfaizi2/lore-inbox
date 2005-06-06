Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFFQY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFFQY3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFFQY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:24:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37508 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261220AbVFFQY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:24:26 -0400
Date: Mon, 6 Jun 2005 12:24:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Harald Welte <laforge@gnumonks.org>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via
 usbdevio
In-Reply-To: <20050606160531.GG6596@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.44L0.0506061222380.5651-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Harald Welte wrote:

> On Wed, Jun 01, 2005 at 12:12:58AM +0200, Harald Welte wrote:
> 
> > > > Wouldn't it help to associate the URB with the file (instaed of the
> > > > task), and then send the signal to any task that still has opened the
> > > > file?  I'm willing to hack up a patch, if this is considered a sane fix.
> > > 
> > > Sounds reasonable, except that not all such tasks will want the signal.
> > > Though I guess the infrastructure to filter the signal out already exists,
> > > so the main missing piece is that urb-to-file binding.
> > 
> > Ok, I'll get something coded shortly.
> 
> Unfortunately this approach is not feasible, since there is no 'reverse
> mapping' from a file to a process.  So for every URB delivery, we would
> have to walk that task_list and check which tasks have opened this file.

What about something like the standard FSETOWN fnctl?

Alan Stern

