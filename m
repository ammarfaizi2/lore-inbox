Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbULJAMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbULJAMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbULJAMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:12:53 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:1410 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261554AbULJAMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:12:52 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB fixes for 2.6.10-rc3
Date: Thu, 9 Dec 2004 16:12:38 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20041209230900.GA6091@kroah.com> <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org> <20041209235709.GA8147@kroah.com>
In-Reply-To: <20041209235709.GA8147@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412091612.38820.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 December 2004 3:57 pm, Greg KH wrote:
> 
> Yeah, it's not the cleanest, and yes, it is just shutting the warning
> up, but that's ok in this case.  I guess I could look into doing the
> "two different structures" type thing again, if people don't like things
> like this in different places.

Or maybe just cache a pre-swapped value in the wrapper
structure (usb_host_config)?  You don't need to create
a third structure ... and it'd be nice to have simple
rule that the raw descriptors are always in wire order.

- Dave
