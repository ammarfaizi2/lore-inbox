Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUCaPc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUCaPc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:32:29 -0500
Received: from ida.rowland.org ([192.131.102.52]:9220 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262027AbUCaPc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:32:26 -0500
Date: Wed, 31 Mar 2004 10:32:25 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       <maneesh@in.ibm.com>, <viro@math.psu.edu>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Unregistering interfaces
In-Reply-To: <406A0C15.7090506@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0403311029230.1752-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, David Brownell wrote:

> Alan Stern wrote:
> 
> > 	  I'm in favor of changing the behavior of sysfs, so that either it
> > refuses to delete directories that contain subdirectories or else it
> > recursively deletes the subdirectories first.  At this point nothing has
> > been settled.
> 
> Hmm, certainly I agree khubd should be deleting things bottom-up.
> 
> Are you say it isn't doing that already?  Or that it's trying to,
> but something's preventing that from working?

No, no -- as far as I know khudb gets rid of things in a perfectly correct
manner.  But there are plenty of other parts in the Linux kernel, and I
don't know that they all delete things bottom-up.  Greg implies that
usb-serial and the kernel's tty subsystem don't do this; I haven't had a
chance to look into it.

Alan Stern

