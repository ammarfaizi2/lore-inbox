Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUAWRmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUAWRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:42:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:20668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbUAWRmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:42:13 -0500
Date: Fri, 23 Jan 2004 09:42:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.58.0401230939170.2151@home.osdl.org>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jan 2004, Alan Stern wrote:
>
> Since I haven't seen any progress towards implementing the 
> class_device_unregister_wait() and platform_device_unregister_wait() 
> functions, here is my attempt.

So why would this not deadlock?

The reason we don't wait on things like this is that it's basically
impossible not to deadlock.

There are damn good reasons why the kernel uses reference counting 
everywhere. Any other approach is broken.

		Linus
