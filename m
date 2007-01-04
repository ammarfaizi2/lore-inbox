Return-Path: <linux-kernel-owner+w=401wt.eu-S964857AbXADNZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbXADNZl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbXADNZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:25:41 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:9702 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964857AbXADNZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:25:40 -0500
X-AuditID: d80ac287-a3d59bb000002548-0e-459d0128bd2b 
Date: Thu, 4 Jan 2007 13:25:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       torvalds@osdl.org, gelma@gelma.net, linux-kernel@vger.kernel.org
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <20070103230629.a2e734b9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701041318020.29210@blonde.wat.veritas.com>
References: <20070103214121.997be3e6.akpm@osdl.org> <459C98BF.5080409@yahoo.com.au>
 <20070103221220.c4589831.akpm@osdl.org> <20070103.225607.133169483.davem@davemloft.net>
 <20070103230629.a2e734b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 13:25:39.0059 (UTC) FILETIME=[D3404C30:01C73003]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Andrew Morton wrote:
> On Wed, 03 Jan 2007 22:56:07 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > > 
> > > It'd odd that stories of pre-2.6.19 BerkeleyDB corruption are now coming
> > > out of the woodwork.  It's the first I've ever heard of them.
> > 
> > Note that the original rtorrent debian bug report was against 2.6.18
> 
> I think that was 2.6.18+debian-added-dirty-page-tracking-patches.

That's right.  Debian's 2.6.18-3, not -stable's 2.6.18.3 as Linus feared.
I'll be sending 2.6.18-stable the fix to the msync ENOMEM-on-unmapped
issue later today (that little buglet being what led them to integrate
the much more interesting dirty page tracking patches, which happened
to fix it in passing).

Hugh
