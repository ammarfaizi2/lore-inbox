Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVBCAE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVBCAE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVBBXw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:52:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262450AbVBBXqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:46:09 -0500
Date: Wed, 2 Feb 2005 18:46:00 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107386909.19339.9.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502021842140.5331-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Fruhwirth Clemens wrote:

> > > +static int ecb_process_gw(void *_priv, int nsg, void **buf) 
> 
> > What does _gw mean?
> 
> generic walker.. can be removed, if you like.

That's fine, was just wondering.

> > > +		r = pf(priv, nsl, dispatch_list);
> > > +		if(unlikely(r < 0))
> > > +			goto out;
> > 
> > Not sure if the unlikely() is justified here, given that this is not a 
> > fast path.  I guess it doesn't do any harm.
> 
> I suspected unlikely to be a hint for the compiler to do better jump
> prediction and speculations. Remove?

Correct, although I think this will get lost in the noise given that it's 
sitting in the middle of crypto processing.  I'd remove it.


- James
-- 
James Morris
<jmorris@redhat.com>


