Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTELUsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTELUsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:48:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18643 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262694AbTELUsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:48:22 -0400
Date: Mon, 12 May 2003 14:02:22 -0700
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse freezes under X, 2.5.69-mm3
Message-ID: <20030512210222.GA29652@kroah.com>
References: <1052772819.4835.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052772819.4835.6.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 01:53:39PM -0700, Bryan O'Sullivan wrote:
> I occasionally see my USB mouse freeze up under X11 on a Red Hat 9
> system running 2.5.69-mm3.  It completely stops responding to events
> until I either switch virtual terminals or restart X, then magically
> comes back to life.

Does this also happem on a non-mm kernel?

> There are no entries in /var/log/messages to indicate what might be
> going on, so I'm quite mystified.
> 
> This is on a system with USB compiled in modular form, though I notice
> that, weirdly enough, the refcounts on everything USB-related except
> usbcore are zero (i.e. hid, uhci_hcd, ehci_hcd), even though I'm using
> the USB mouse right now.

The hid driver never increments its user count, even when being used.
Same goes for the USB host controller drivers, so this is not a problem.

thanks,

greg k-h
