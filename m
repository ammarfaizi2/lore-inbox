Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWFWCpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWFWCpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWFWCpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:45:18 -0400
Received: from mx2.rowland.org ([192.131.102.7]:59916 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750967AbWFWCpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:45:16 -0400
Date: Thu, 22 Jun 2006 22:45:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-pm@osdl.org>, <pavel@suse.cz>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
In-Reply-To: <20060622235112.GA30484@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0606222241390.18690-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Greg KH wrote:

> > And yes, we _should_ care about whether or not any interface is
> > still active, until the pm core code starts to pay attention to
> > the driver model tree at all times ... even outside of system-wide
> > suspend transitions.  Today, the pm core code doesn't even use
> > that tree directly, and all runtime state changes (like selective
> > suspend with USB) completely bypass that pm tree.
> 
> Hm, ok, yes, we should care about interfaces, but we need some way to
> only walk them, not anything else that might be attached to us...

In my upcoming patch set this test isn't needed at all, because suspending
a device automatically suspends all of its interfaces first.  I've already
submitted the first few revised patches in that set (not the part that
removes the test, though), but you've probably been too busy to look at
them yet.

Alan Stern

