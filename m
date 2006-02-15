Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWBOWwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWBOWwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBOWwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:52:03 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60626 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750934AbWBOWwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:52:01 -0500
Date: Wed, 15 Feb 2006 17:51:59 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
In-Reply-To: <20060215223712.GA28956@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0602151745040.4817-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Greg KH wrote:

> > > It would only go on the list if the "put" was the last one.  Otherwise
> > > it would not make any sense to put it on any list.
> > 
> > There's no way to know whether or not any particular "put" is the last 
> > one.  So you have to assume they all are.
> 
> The underlying kobject can "know" that the put was the last one, and
> handle it differently if needed.  Yes, it would not use a kref anymore,
> but that might be needed here.

You would need a kref variant, something which would include room for the
list header and a pointer to the release routine.  Okay, that does involve 
less time overhead than what I proposed (although the same amount of space 
overhead).

Alan Stern

