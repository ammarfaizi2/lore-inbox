Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVGHQtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVGHQtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVGHQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:49:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:59586 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262711AbVGHQti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:49:38 -0400
Date: Fri, 8 Jul 2005 09:48:16 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: device_find broken in 2.6.11?
Message-ID: <20050708164816.GB17723@kroah.com>
References: <1120796213.12218.55.camel@localhost.localdomain> <20050708042922.GA4603@kroah.com> <1120836964.12218.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120836964.12218.63.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 01:36:04AM +1000, Rusty Russell wrote:
> On Thu, 2005-07-07 at 21:29 -0700, Greg KH wrote:
> > On Fri, Jul 08, 2005 at 02:16:53PM +1000, Rusty Russell wrote:
> > > 
> > > 	I was getting oopses in kset_find_obj when calling device_find in
> > > 2.6.11.12.
> > 
> > Yup, there's a reason no one uses it.  Use the version in 2.6.13-rc2, it
> > actually works.
> > 
> > What are you wanting to use it for?
> 
> The xenbus code

What is that?  Any pointers to it?

> wants to find if a device is new:

new to whom?  Busses usually drive the finding of new devices, so they
always know when a device has been found or goes away.

> the Xen code is currently against on 2.6.11.12.

If you have code that is using the driver core, it will need big changes
for 2.6.13 due to the internal rework that we have done.  I suggest you
start now :)

Good luck,

greg k-h
