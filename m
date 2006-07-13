Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWGMGBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWGMGBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWGMGBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:01:09 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:11658 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932323AbWGMGBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:01:08 -0400
Date: Wed, 12 Jul 2006 23:01:03 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org, rdreier@cisco.com,
       mst@mellanox.co.il, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
 on PowerPC 970 systems
In-Reply-To: <fa.HMAEhxazNte2HunfwrtIBHxnTgk@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0607122300150.23167@osa.unixfolk.com>
References: <fa.yuLZwM7z1gdxIxZzuZ+ngT30guw@ifi.uio.no>
 <fa.HMAEhxazNte2HunfwrtIBHxnTgk@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Benjamin Herrenschmidt wrote:

| On Thu, 2006-07-06 at 16:34 -0700, Bryan O'Sullivan wrote:
| > On Fri, 2006-07-07 at 08:37 +1000, Benjamin Herrenschmidt wrote:
| > 
| > > > +int ipath_unordered_wc(void)
| > > > +{
| > > > +	return 1;
| > > > +}
| > > 
| > > How is the above providing any kind of serialisation ?
| > 
| > It's not intended to; it tells the *caller* whether to do it.
| 
| Ah ok. What barrier do you use for that ?

on x86_64, the sfence instruction, on others, wmb(), in the kernel.  In user-land,
pretty much the same underlying assembly instructions.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
