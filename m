Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWCIX7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWCIX7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWCIX7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:59:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:38793 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932117AbWCIX7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:59:37 -0500
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060309234607.GA26898@kroah.com>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>  <20060309234607.GA26898@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:59:37 -0800
Message-Id: <1141948777.10693.61.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:46 -0800, Greg KH wrote:
> On Thu, Mar 09, 2006 at 03:18:49PM -0800, Roland Dreier wrote:
> 
> Thanks for CC:ing me, but where were the originals of these posted?

My patch posting script screwed up.  Only Roland got them, even though
the envelopes were all correct.

> >  > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
> >  > +{
> >  > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
> >  > +
> >  > +	return sizeof(ipath_stats);
> >  > +}
> > 
> > I think putting a whole binary struct in a sysfs attribute is
> > considered a no-no.
> 
> That's an understatement, where is the large stick to thwap the author
> of this code...

I'd like to understand why, though.  As I already explained, it's a
smallish structure (< 1KB), and I can use the special binary sysfs
attribute goo for it if you insist, but ... why?

	<b

