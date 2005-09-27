Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVI0IEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVI0IEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVI0IEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:04:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:65506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964808AbVI0IEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:04:47 -0400
Date: Tue, 27 Sep 2005 01:04:15 -0700
From: Greg KH <greg@kroah.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927080413.GA13149@kroah.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925151330.GL731@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, thanks for providing a patch for this problem, it is real,
and has been known for a while (thanks to your debugging :)

On Sun, Sep 25, 2005 at 05:13:30PM +0200, Harald Welte wrote:
> 
> I suggest this (or any other) fix to be applied to both 2.6.14 final and
> the stable series.  I didn't yet investigate 2.4.x, but I think it is
> likely to have the same problem.

I agree, but I think we need an EXPORT_SYMBOL_GPL() for your newly
exported symbol, otherwise the kernel will not build if you have USB
built as a module.

thanks,

greg k-h
