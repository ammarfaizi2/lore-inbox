Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbULJAT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbULJAT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbULJAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:19:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:62970 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261567AbULJAT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:19:57 -0500
Date: Thu, 9 Dec 2004 16:19:32 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB fixes for 2.6.10-rc3
Message-ID: <20041210001932.GA10889@kroah.com>
References: <20041209230900.GA6091@kroah.com> <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org> <20041209235709.GA8147@kroah.com> <Pine.LNX.4.58.0412091606130.31040@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412091606130.31040@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 04:08:33PM -0800, Linus Torvalds wrote:
> On Thu, 9 Dec 2004, Greg KH wrote:
> > Yeah, it's not the cleanest, and yes, it is just shutting the warning
> > up, but that's ok in this case.  I guess I could look into doing the
> > "two different structures" type thing again, if people don't like things
> > like this in different places.
> 
> On the other hand, maybe you could just leave it in "hardware byte order". 

True.  Nothing like changing the byte order of structure fields to
really drive the "out-of-tree" driver writers crazy.  I like it :)

> That's something that sparse really can help with - it should pinpoint 
> exactly everybody who uses it, and give a reasonable error for them, so 
> that everybody can agree on the byte-order.

Hm, I'll look into doing that after 2.6.10, as it does make more sense
in the long run.

thanks,

greg k-h
