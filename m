Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWBOWZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWBOWZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWBOWZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:25:39 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:2200 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751335AbWBOWZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:25:38 -0500
Date: Wed, 15 Feb 2006 17:25:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
In-Reply-To: <20060215215957.GA25784@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0602151725080.4817-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Greg KH wrote:

> On Wed, Feb 15, 2006 at 04:52:43PM -0500, Alan Stern wrote:
> > On Wed, 15 Feb 2006, Greg KH wrote:
> > 
> > > On Wed, Feb 15, 2006 at 05:35:08PM +0100, Arjan van de Ven wrote:
> > > > On Wed, 2006-02-15 at 08:27 -0800, Greg KH wrote:
> > > > > 
> > > > > Nah, I don't think it's a good idea.  James's patch should work just
> > > > > fine.
> > > > 
> > > > another option is to have a "kill list" which you put the thing on, and
> > > > then wake up a thread. only 2 pointers in the object ;(
> > > 
> > > Hm, that's almost what James's patch is trying to do.  Care to mock up a
> > > patch that shows this?  It might be a simpler solution.
> > 
> > It won't work.  You might have to do 2 put_device calls on the same 
> > structure.  That's why I suggested the "pending puts" counter; something 
> > can't go on a list more than once.
> 
> It would only go on the list if the "put" was the last one.  Otherwise
> it would not make any sense to put it on any list.

There's no way to know whether or not any particular "put" is the last 
one.  So you have to assume they all are.

Alan Stern

