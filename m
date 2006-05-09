Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWEINOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWEINOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWEINOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:14:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:55684 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750974AbWEINOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:14:36 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual =?utf-8?q?network=09device=09driver=2E?=
Date: Tue, 9 May 2006 15:14:28 +0200
User-Agent: KMail/1.9.1
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, chrisw@sous-sol.org,
       ian.pratt@xensource.com, xen-devel@lists.xensource.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1FdRpp-0008HG-00@gondolin.me.apana.org.au>
In-Reply-To: <E1FdRpp-0008HG-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091514.29205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 15:01, Herbert Xu wrote:
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

I guess they don't trust user space. But the standard ipup script
from iproute2 does this already so at least for modern distributions
it should just work.

-Andi
