Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWEIOAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWEIOAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWEIOAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:00:42 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:54936 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751041AbWEIOAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:00:41 -0400
Date: Tue, 9 May 2006 15:00:27 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, virtualization@lists.osdl.org
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network	device	driver.
Message-ID: <20060509140027.GD7834@cl.cam.ac.uk>
References: <20060509131632.GB7834@cl.cam.ac.uk> <E1FdSDz-0008Lv-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FdSDz-0008Lv-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:26:03PM +1000, Herbert Xu wrote:
> Christian Limpach <Christian.Limpach@cl.cam.ac.uk> wrote:
> > 
> > Possibly having to page in the process and switching to it would add
> > to the live migration time.  More importantly, having to install an
> > additional program in the guest is certainly not very convenient.
> 
> Sorry I'm still not convinced.  What's there to stop me from suspending
> my laptop to disk, moving it from port A to port B and resuming it?
> 
> Wouldn't I be in exactly the same situation? By the same reasoning we'd
> be adding a gratuitous ARP routine to every single laptop network driver.

It is the same situation except that in the laptop case you don't care
that reconfiguring your network will take a second or a few.  For live
migration we're looking at network downtime from as low as 60ms to
something like 210ms on a busy virtual machine.  I'm not saying that
a userspace solution wouldn't work but it would probably add a measurable
delay to the network downtime during live migration.

You might also find the following paper an interesting read:
http://www.cl.cam.ac.uk/Research/SRG/netos/papers/2005-migration-nsdi-pre.pdf

    christian

