Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUAGS6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUAGS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:58:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:53737 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264940AbUAGS6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:58:01 -0500
Date: Wed, 7 Jan 2004 10:57:00 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107185656.GB31827@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 10:38:31AM -0800, Linus Torvalds wrote:
> 
> On Fri, 2 Jan 2004, Greg KH wrote:
> > 
> > Doesn't the kernel always create the main block device for this device?
> > If so, udev will catch that.
> 
> But udev should probably also create all the sub-nodes if it doesn't 
> already.

It doesn't, as I thought we could rely on the kernel partition support.

> And it really has to create _all_ of them, exactly because there's no way
> to know ahead-of-time which of them will be available.
> 
> Then, user space can just access "/dev/sda1" or whatever, and the act of 
> accessing it will force the re-scan.

Hm, that would work, but what about a user program that just polls on
the device, as the rest of this thread discusses?  As removable devices
are not the "norm" it would seem a bit of overkill to create 16
partitions for every block device, if they need them or not.

thanks,

greg k-h
