Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWEXVYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWEXVYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWEXVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:24:21 -0400
Received: from ozlabs.org ([203.10.76.45]:16619 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932471AbWEXVYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:24:21 -0400
Date: Thu, 25 May 2006 07:21:17 +1000
From: Anton Blanchard <anton@samba.org>
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Message-ID: <20060524212117.GD5938@krispykreme>
References: <20060517220218.GA13411@myri.com> <20060517220608.GD13411@myri.com> <20060523153928.GB5938@krispykreme> <4474138C.2050705@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4474138C.2050705@myri.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> We didn't get any ppc64 with PCI-E to run Linux so far. What performance
> drop should we expect with our current code ?

We have seen > 20% improvement on ppc64 running some networking
workloads when forcing 128 byte alignment (instead of 16 byte
alignment). DMA writes have to get cacheline aligned (in power of 2
steps) on some IO chips.

> I am not sure what you mean.
> The only ppc64 with PCI-E that we have seen so far (a G5) couldn't do
> write combining according to Apple.

Im thinking more generally, MTRRs are x86 specific and it would be good
to have a more generic way to enable write combining.

Anton
