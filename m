Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUL3QVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUL3QVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUL3QVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:21:46 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:5614 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261666AbUL3QV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:21:29 -0500
Subject: Re: [RFC 2.6.10 1/22] xfrm: Add direction information to xfrm_state
From: Dave Dillow <dave@thedillows.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <200412301436.06653.ioe-lkml@axxeo.de>
References: <20041230035000.01@ori.thedillows.org>
	 <20041230035000.10@ori.thedillows.org>
	 <200412301436.06653.ioe-lkml@axxeo.de>
Content-Type: text/plain
Message-Id: <1104423687.23254.15.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Dec 2004 11:21:27 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2004 16:21:27.0401 (UTC) FILETIME=[9CEF4D90:01C4EE8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[readding netdev to the cc list]

On Thu, 2004-12-30 at 08:36, Ingo Oeser wrote:
> Hi David,
> 
> I'm happy to see a framework and example driver for this.

Thanks, I'm just glad it works.

> David Dillow schrieb:
> > diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
> > --- a/include/net/xfrm.h 2004-12-30 01:12:08 -05:00
> > +++ b/include/net/xfrm.h 2004-12-30 01:12:08 -05:00
> > @@ -194,6 +203,7 @@
> >   struct xfrm_state *(*find_acq)(u8 mode, u32 reqid, u8 proto,
> >            xfrm_address_t *daddr, xfrm_address_t *saddr,
> >            int create);
> > + void   (*map_direction)(struct xfrm_state *xfrm);
> >  };
> >
> 
> Please don't build modifiers, but build functions instead.
> 
> e.g. 
> 
> xfrm->direction = map_direction(xfrm)
> 
> That way you don't hide the assignment and thus code becomes much clearer and
> can be called multiple times without risk.

I'll make the change for the next iteration.
-- 
Dave Dillow <dave@thedillows.org>

