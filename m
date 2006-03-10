Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWCJWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCJWah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWCJWah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:30:37 -0500
Received: from palrel10.hp.com ([156.153.255.245]:57517 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932268AbWCJWag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:30:36 -0500
Date: Fri, 10 Mar 2006 14:30:41 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another round for review
Message-ID: <20060310223041.GA15307@esmail.cup.hp.com>
References: <patchbomb.1141950930@eng-12.pathscale.com> <20060310153559.GA12778@mellanox.co.il> <1142006537.29925.13.camel@serpentine.pathscale.com> <20060310174806.GA13969@esmail.cup.hp.com> <1142013259.29925.69.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142013259.29925.69.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:54:19AM -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-03-10 at 09:48 -0800, Grant Grundler wrote:
> 
> > My gut feeling is you want to look at SDP first.
> 
> We already implement SDP.

ah ok.
Is your SDP slower than the "ethernet emulation" for message passing?

> > I'm skeptical that yet another wire protocol will get
> > accepted into the linux kernel.
> 
> It's just a simple net device driver.

I guess I need to look at the code if I want to understand
what "ethernet emulation" and "simple net device driver"
exactly mean.

You missed the netdev and netfilter guys ranting when Infiniband
promoters proprosed putting a switch in the kernel to bypass
the TCP/IP stack when SDP was available. This happened at OLS2004
Infiniband BOF. Very strong opposition to SDP masquerading
as AF_INET.  SDP is squatting on AT_INET_SDP (27) until it
gets integrated in the kernel.

hth,
grant
