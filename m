Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTKITtr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKITtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:49:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:59548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262224AbTKITtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:49:46 -0500
Date: Sun, 9 Nov 2003 11:42:11 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bug (?) in subsystem kset refcounts
Message-ID: <20031109194211.GA1932@kroah.com>
References: <20031109042936.GA8583@kroah.com> <Pine.LNX.4.44L0.0311091151480.20291-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0311091151480.20291-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 12:01:41PM -0500, Alan Stern wrote:
> It's unfortunate that initialization of various parts of a kobject or
> driver-model object is so order-sensitive.  Worse yet is the fact that
> these dependencies are not mentioned in Documentation/kobject.txt,
> Documentation/driver-model, include/linux/kobject.h, or
> include/linux/device.h.  Wouldn't it be a good idea to add, for example to
> Documentation/kobject.txt, a description of which members of struct
> kobject must be initialized before calling kobject_init() and which must
> be initialized before calling kobject_add()?  And of course to do the same
> for all the other important structures as well.

I agree.  More documentation is definitely needed.  I know Pat has some
documentation changes queued up, but patches to update portions that are
missing (such as these requirements) will always be gladly accepted.

thanks,

greg k-h
