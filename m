Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTL2Vi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTL2Vi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:38:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:11955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264258AbTL2ViV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:38:21 -0500
Date: Mon, 29 Dec 2003 12:15:56 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-net@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let USB_{PEGASUS,USBNET} depend on NET_ETHERNET
Message-ID: <20031229201556.GE7980@kroah.com>
References: <20031221022242.GT12750@fs.tum.de> <3FE630D7.7070007@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE630D7.7070007@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 03:46:31PM -0800, David Brownell wrote:
> Adrian Bunk wrote:
> >I observed the following small problem in 2.6:
> >
> >- MII depends on NET_ETHERNET
> >- USB_PEGASUS and USB_USBNET select MII, but they depend only on NET
> > 
> >The patch below lets USB_PEGASUS and USB_USBNET depend on NET_ETHERNET 
> >instead of NET to fix this issue.
> 
> Actually how about this one instead?  The PEGASUS bit is the same.
> The difference is that MII (and CRC32) are only attributed to the
> driver code that needs those ... AX8817X needs both, ZAURUS just
> needs CRC32.  The core (which should eventually become a separate
> module) shouldn't depend on those modules at all.
> 
> Also both CDCETHER and AX8817X are marked as non-experimental;
> I recall Dave Hollis submitted a patch to do that for AX8817X,
> and CDCETHER now seems to have gotten enough success reports too.

Thanks, I've merged this by hand and applied it to my trees.

greg k-h
