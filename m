Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbVLRWKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbVLRWKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbVLRWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:10:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:34727 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965290AbVLRWK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:10:29 -0500
Date: Sun, 18 Dec 2005 13:50:51 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
Message-ID: <20051218215051.GA18257@kroah.com>
References: <1134937642.6102.85.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134937642.6102.85.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 07:27:21AM +1100, Benjamin Herrenschmidt wrote:
> Hi David, Alan !
> 
> What exactly changed in the recent USB stacks that is causing it to
> abort system suspend much more often ? I'm getting lots of user reports
> with 2.6.15-rc5 saying that they can't put their internal laptops to
> sleep, apparently because a driver doesn't have a suspend method
> (internal bluetooth in this case).
> 
> It's never been mandatory so far for all drivers of all connected
> devices to have a suspend method... didn't we decide back then that
> disconneting those was the right way to go ?

Yes it is, and I have a patch in my tree now that fixes this up and
keeps the suspend process working properly for usb drivers that do not
have a suspend function.

Hm, I wonder if it should go in for 2.6.15?

thanks,

greg k-h
