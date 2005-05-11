Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVEKU3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVEKU3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVEKU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:29:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:56480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262041AbVEKU3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:29:04 -0400
Date: Wed, 11 May 2005 13:28:05 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org,
       Justin Thiessen <jthiessen@penguincomputing.com>
Subject: Re: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-ID: <20050511202805.GB2222@kroah.com>
References: <2538186705051100583c6b1ffb@mail.gmail.com> <20050511170600.GD15398@kroah.com> <25381867050511125761fcfad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25381867050511125761fcfad0@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 03:57:37PM -0400, Yani Ioannou wrote:
> On 5/11/05, Greg KH <greg@kroah.com> wrote:
> > On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> > Sorry, but I need a real patch in email form so I can apply it.  I can
> > handle a 300K+ email :)
> > 
> > Or you can break it up into smaller pieces, like one per major part of
> > the kernel.  That is the preferred way.
> 
> I'd like to break it up, but I think even broken up by major part of
> the kernel it one piece will still be too large since the majority of
> the changes take place in drivers & drivers/i2c and are very
> asymmetric :-(. I'll send you the patch inline privately for now.

No, please break it up.  "too large" is a problem for someone trying to
review it too.  If the i2c parts are too big, then split them up into
multiple patches too.

> > We should make a __ATTR macro instead, right?
> 
> Well another __ATTR macro (e.g. ATTR_PRIVATE) would make declaring the
> new DEVICE_ATTR_PRIVATE macro, etc, easier.

Sorry, yes, that's what I ment.

> The question really is, is it better to just add that new parameter to
> the DEVICE_ATTR macro, or to declare a new DEVICE_ATTR_PRIVATE macro
> instead. The former obviously breaks a lot of code although my scripts
> can generate another large patch for that too...

No, use a new macro.

thanks,

greg k-h
