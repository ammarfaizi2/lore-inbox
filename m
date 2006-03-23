Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWCWX6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWCWX6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWCWX6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:58:53 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16597 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422722AbWCWX6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:58:52 -0500
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
In-Reply-To: <adaacbhvujm.fsf@cisco.com>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	 <20060323064113.GC9841@mellanox.co.il>
	 <1143103701.6411.21.camel@camp4.serpentine.com> <adaacbhvujm.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 23 Mar 2006 15:58:52 -0800
Message-Id: <1143158332.11449.33.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 11:18 -0800, Roland Dreier wrote:

> But I still (after all this discussion)
> don't understand why you need to have two SMA implementations to
> handle this along with the code to switch between the two modes like:

I'm a bit confused by your question.  We only have one SMA
implementation, which is in userspace.  The stuff that's in our core
driver is purely for supporting it.  That same code is also used during
diags, too, to let userspace send and receive low-level packets.

The code in ipath_mad.c simply handles requests for ib_mad, if the
in-kernel SMA is being used.

> You also have all the functions like recv_subn_get_nodeinfo() etc. for
> handling SM queries.  Presumably all this is duplicated in the
> userspace SMA.

Only a very small subset of SMA functionality is present in the
userspace SMA.

	<b

