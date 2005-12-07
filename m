Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbVLGSfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbVLGSfI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbVLGSfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:35:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:25293 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751724AbVLGSfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:35:07 -0500
Date: Wed, 7 Dec 2005 09:04:27 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207170426.GB28414@kroah.com>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512070105.40169.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 01:05:39AM -0500, Dmitry Torokhov wrote:
> On Monday 05 December 2005 15:27, Russell King wrote:
> > On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > > The name parameter of platform_device_register_simple should be of
> > > type const char * instead of char *, as we simply pass it to
> > > platform_device_alloc, where it has type const char *.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > However, I've been wondering whether we want to keep this "simple"
> > interface around long-term given that we now have a more flexible
> > platform device allocation interface - I don't particularly like
> > having superfluous interfaces for folk to get confused with.
> 
> Now that you made platform_device_alloc install default release
> handler there is no need to have the _simple interface. I will
> convert input devices (main users of _simple) to the new interface
> and then we can get rid of it.

That sounds like a very good idea.

thanks,

greg k-h
