Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbUB0UU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUB0UU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:20:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:61136 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263102AbUB0USW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:18:22 -0500
Date: Fri, 27 Feb 2004 12:17:44 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about (or bug in?) the kobject implementation
Message-ID: <20040227201744.GA11291@kroah.com>
References: <20040227194855.GB10864@kroah.com> <Pine.LNX.4.44L0.0402271457530.1225-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402271457530.1225-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 03:06:32PM -0500, Alan Stern wrote:
> On Fri, 27 Feb 2004, Greg KH wrote:
> > Seriously, once kobject_del() is called, you can't safely call
> > kobject_get() anymore on that object.
> 
> Are you worried about the possibility of the refcount dropping to 0 and 
> the cleanup starting but then kobject_get() increasing the refcount again?

Exactly, that is where the problem could happen.

thanks,

greg k-h
