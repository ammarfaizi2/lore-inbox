Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUA0UaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUA0U37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:29:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:31713 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265751AbUA0U3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:29:55 -0500
Date: Tue, 27 Jan 2004 12:29:44 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040127202944.GE27240@kroah.com>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <Pine.LNX.4.58.0401261435160.7855@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401261435160.7855@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 05:22:41PM +0100, Roman Zippel wrote:
> 
> All this is done without a module count, this means that
> pci_unregister_driver() cannot return before the last reference is gone.
> For network devices this is not that much of a problem, as they can be
> rather easily deconfigured automatically, but that's not that easy for
> mounted block devices, so one has to be damned careful when to call the
> exit function.

Um, not anymore.  I can yank out a mounted block device and watch the
scsi core recover just fine.  The need to make everything hotpluggable
has fixed up a lot of issues like this (as well as made more
problems...)

thanks,

greg k-h
