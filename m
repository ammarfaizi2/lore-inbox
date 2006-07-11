Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWGKWFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWGKWFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWGKWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:05:11 -0400
Received: from mx.pathscale.com ([64.160.42.68]:153 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932182AbWGKWFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:05:09 -0400
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
	keep cache pressure down
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <20060711.145751.77136364.davem@davemloft.net>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
	 <20060711.135729.104381402.davem@davemloft.net>
	 <1152653401.16499.35.camel@chalcedony.pathscale.com>
	 <20060711.145751.77136364.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 15:05:08 -0700
Message-Id: <1152655509.16499.49.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 14:57 -0700, David Miller wrote:

> I didn't realize there was change afoot in this area, sorry.
> I was just striving for consistency with current practice.

Sure.

> When the kernel is linked, lib.a implementations only get brought in
> if they are not already resolved by definitions present in the other
> objects of the kernel image.

Well, exactly this scheme seems to work for __iowrite_copy*.  There's a
weak generic version and a strong version in arch/x86_64/lib that
overrides it, and it gets picked up at kernel link time.

It could be working by accident, I suppose, but it's at least consistent
behaviour with what I'm used to from weak symbols.

	<b

