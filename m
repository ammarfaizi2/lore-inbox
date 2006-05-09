Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWEINQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWEINQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWEINQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:16:49 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:37778 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932505AbWEINQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:16:48 -0400
Date: Tue, 9 May 2006 14:16:32 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, virtualization@lists.osdl.org
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network	device	driver.
Message-ID: <20060509131632.GB7834@cl.cam.ac.uk>
References: <20060509124359.GA5407@cl.cam.ac.uk> <E1FdRpp-0008HG-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FdRpp-0008HG-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:01:05PM +1000, Herbert Xu wrote:
> Christian Limpach <Christian.Limpach@cl.cam.ac.uk> wrote:
> > 
> > There's at least two reasons why having it in the driver is preferable:
> > - synchronizing sending the fake ARP request with when the device is
> >  operational -- you really want to make this well synchronized to keep
> >  unreachability as short as possible, especially when doing live
> >  migration
> > - anybody but the guest might not know (all) the MAC addresses for which
> >  to send a fake ARP request
> 
> Sure.  However, what's there to stop you from doing this in user-space
> inside the guest?

Possibly having to page in the process and switching to it would add
to the live migration time.  More importantly, having to install an
additional program in the guest is certainly not very convenient.

    christian

