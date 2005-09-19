Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVISSG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVISSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVISSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:06:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33183 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932539AbVISSG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:06:56 -0400
Date: Mon, 19 Sep 2005 14:06:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unusually long delay in the kernel
In-Reply-To: <20050917164117.1eee31c2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509191405310.4456-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2005, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > Presumably it's spinning on the bkl.  Is this actually an SMP machine?  If
> > > so, perhaps some other process is holding the bkl for a long time.  Perhaps
> > > a netdevice spending a long time diddling hardware in an ioctl, something
> > > like that.
> > 
> > I need to do more precise tests.  Some quick informal tests indicated that 
> > the lock_kernel call and the daemonize call each took a noticeable time.  
> 
> Something odd is happening.

Forget about this.  It turned out to be an unexpected side effect from the 
problems with the SCSI error handler.  Once that was fixed, the delay went 
away.

Alan Stern

