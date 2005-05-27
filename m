Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVE0LUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVE0LUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 07:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVE0LUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 07:20:45 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:59398
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262436AbVE0LUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 07:20:41 -0400
Date: Fri, 27 May 2005 04:20:39 -0700
From: Phil Oester <kernel@linuxace.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       cedric@schieli.dyndns.org, coreteam@netfilter.org
Subject: Re: [PATCH] Avoid unncessary checksum validation in TCP/UDP netfilter
Message-ID: <20050527112039.GA10084@linuxace.com>
References: <E1DbccR-00063Q-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DbccR-00063Q-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 12:03:08PM +0100, Keir Fraser wrote:
> The TCP/UDP connection-tracking code in netfilter validates the
> checksum of incoming packets, to prevent nastier errors further down
> the road. This check is unnecessary if the skb is marked as
> CHECKSUM_UNNECESSARY. 

It seems at least part of this has already been merged in 2.6.12-rc

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=721ddbf522b422d554479a7ab15c0955798f16ee;hp=2b87c1974be605d5bdb1ee769188d7e03fb2ddc8;hb=31da185d8162ae0f30a13ed945f1f4d28d158133;f=net/ipv4/netfilter/ip_conntrack_proto_tcp.c

Phil
