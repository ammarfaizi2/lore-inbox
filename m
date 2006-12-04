Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937098AbWLDQ21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937098AbWLDQ21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937099AbWLDQ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:28:27 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:60491 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937098AbWLDQ2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:28:25 -0500
Subject: Re: [PATCH  v2 03/13] Provider Methods and Data Structures
From: Steve Wise <swise@opengridcomputing.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1165147639.3233.211.camel@laptopd505.fenrus.org>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224947.27014.59189.stgit@dell3.ogc.int>
	 <1165147639.3233.211.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:28:25 -0600
Message-Id: <1165249706.32724.35.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 13:07 +0100, Arjan van de Ven wrote:
> On Sat, 2006-12-02 at 16:49 -0600, Steve Wise wrote:
> 
> > +
> > +static struct ib_ah *iwch_ah_create(struct ib_pd *pd,
> > +				    struct ib_ah_attr *ah_attr)
> > +{
> > +	return ERR_PTR(-ENOSYS);
> > +}
> 
> 
> -ENOSYS is just about ALWAYS a bug in that it's guaranteed to be the
> wrong error code ;)

This is a method that is not supported by the iWARP transport.  ENOSYS
indicates this.  I _think_ this is SOP for the infinband subsystem.

Roland, I think at one time we were talking about changing the Core to
better handle this?  Either with attributes/capabilities that the low
level driver can set, or by set these method ptrs to NULL and the core
should handle it in the wrapper function...


Steve.

