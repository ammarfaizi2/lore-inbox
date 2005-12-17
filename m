Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVLQVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVLQVzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVLQVzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:55:55 -0500
Received: from lame.durables.org ([64.81.244.120]:17584 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964982AbVLQVzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:55:54 -0500
Subject: Re: [PATCH 01/13] [RFC] ipath basic headers
From: Robert Walsh <rjwalsh@pathscale.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <84144f020512170433h151a7667o42c382242f81347b@mail.gmail.com>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	 <84144f020512170433h151a7667o42c382242f81347b@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:55:47 -0800
Message-Id: <1134856547.20575.39.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we really need this ugly userspace emulation code in the kernel?

Probably not.  I'll look into removing it.

> What is this used for? Why can't yo use memcpy?

Our chip can only handle double-word copies.

> > +#define round_up(v,sz) (((v) + (sz)-1) & ~((sz)-1))
> 
> Please use ALIGN().

Fair enough.

> You seem to be introducing loads of new ioctls. Any reason you can't
> use sysfs and/or configfs?

I'll see what people here think of that idea.

> > +#define ips_get_ipath_ver(ipath_header) (((ipath_header) >> INFINIPATH_I_VERS_SHIFT) \
> > +        & INFINIPATH_I_VERS_MASK)
> 
> Please use static inlines instead for readability.

OK.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


