Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVFVS0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVFVS0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVFVS0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:26:00 -0400
Received: from sd291.sivit.org ([194.146.225.122]:16388 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262097AbVFVSZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:25:53 -0400
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created
	when probe fails
From: Stelian Pop <stelian@popies.net>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050622162655.GC2274@kroah.com>
References: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org>
	 <1119455608.4651.5.camel@localhost.localdomain>
	 <20050622162655.GC2274@kroah.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 22 Jun 2005 20:25:50 +0200
Message-Id: <1119464750.5080.1.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 09:26 -0700, Greg KH a écrit :

> > -		return -EIO;
> > +		return -ENODEV;
> >  	}
> 
> Also need to do the same a few lines above in the code.  I've fixed that
> too now.

Indeed, especially since the only way to use an alternate driver for a
real hid device is to blacklist it using HID_QUIRK_IGNORE, and in this
case we go through that path.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

