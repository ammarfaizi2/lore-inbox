Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVHJPZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVHJPZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVHJPZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:25:41 -0400
Received: from silver.veritas.com ([143.127.12.111]:33384 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965157AbVHJPZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:25:40 -0400
Date: Wed, 10 Aug 2005 16:27:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gleb Natapov <glebn@voltaire.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband
 uverbs fork support
In-Reply-To: <20050810132611.GP16361@minantech.com>
Message-ID: <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il>
 <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
 <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
 <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com>
 <20050810132611.GP16361@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Aug 2005 15:25:38.0358 (UTC) FILETIME=[C2DE2560:01C59DBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Gleb Natapov wrote:
> On Wed, Aug 10, 2005 at 02:22:40PM +0100, Hugh Dickins wrote:
> > 
> > Your stack example is a good one: if we end up setting VM_DONTCOPY on
> > the user stack, then I don't think fork's child will get very far without
> > hitting a SIGSEGV.
> 
> I know, but I prefer child SIGSEGV than silent data corruption.

Most people will share your preference, but neither is satisfactory.

> In most cases child will exec immediately after fork so no problem
> in this case.

In most(?) cases it won't even be able to exec before the SIGSEGV.

Hugh
