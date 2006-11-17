Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933754AbWKQR7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754AbWKQR7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933755AbWKQR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:59:20 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:941 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S933754AbWKQR7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:59:19 -0500
Subject: Re: [openib-general] [PATCH 02/13] Device Discovery and ULLD
	Linkage
From: Steve Wise <swise@opengridcomputing.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <455DF70C.7090400@pathscale.com>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	 <20061116035837.22635.13571.stgit@dell3.ogc.int>
	 <455DF70C.7090400@pathscale.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 11:59:18 -0600
Message-Id: <1163786358.8457.68.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 09:53 -0800, Bryan O'Sullivan wrote:
> Steve Wise wrote:
> 
> > +static inline void *vzmalloc(int size)
> > +{
> > +	void *p = vmalloc(size);
> > +	memset(p, 0, size);
> > +	return p;
> > +}
> 
> This isn't checking the return value from vmalloc.
> 

Oops...


> Also, we could do with a generic vzalloc and vcalloc, just as we now 
> have kzalloc and kcalloc.  There are lots of routines like this sitting 
> around.
> 
> 	<b

I guess I'll post a kernel patch to add these...



