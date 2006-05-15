Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWEOVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWEOVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWEOVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:21:24 -0400
Received: from mx.pathscale.com ([64.160.42.68]:33669 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965256AbWEOVVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:21:22 -0400
Subject: Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of
	bus_to_virt
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <adad5efuw1o.fsf@cisco.com>
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
	 <adad5efuw1o.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:21:21 -0700
Message-Id: <1147728081.2773.25.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 08:50 -0700, Roland Dreier wrote:

> Actually I NAK'ed this patch.  It compiles the same thing on x86_64
> but makes the source code wrong -- dma_map_single() returns a bus
> address, not a physical address.

As Segher mentioned, bus_to_virt is unportable, so it's definitely the
wrong thing to use.

I don't recall what you suggested instead, but I seem to recall that the
discussion kind of went "oh, right, the layering is all broken".

Any ideas?  Should this turn from a one-liner into a
big-refactor-for-2.6.18 patch?

	<b

