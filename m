Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUGONfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUGONfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUGONfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:35:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266201AbUGONfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:35:05 -0400
Date: Thu, 15 Jul 2004 09:30:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PARCH] driver core: add driver_find to find a driver by name
Message-ID: <20040715123018.GA17486@logos.cnet>
References: <200406272126.05220.dtor_core@ameritech.net> <20040714230246.GF3398@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714230246.GF3398@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 04:02:46PM -0700, Greg KH wrote:
> On Sun, Jun 27, 2004 at 09:26:03PM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Here is a patch that adds driver_find() that allows to search for a driver
> > on a bus by it's name. The function is similar to device_find already present
> > in the tree. I need it for my serio sysfs patches where user can re-bind
> > serio port to an alternate driver by echoing driver's name to serio port's
> > driver attribute.
> 
> Applied, thanks.

Dmitry,

I remember you fixed kset_find_obj() to get a reference count on the kobject.

driver_find()/device_find() use that, maybe it would be nice to add a comment 
on top of those saying the caller is responsible for putting the refcount 
on the kobject?

Last time I looked at your patches there was no such comment on driver_find/device_find, 
only kset_find_obj().

Just nitpicking.
