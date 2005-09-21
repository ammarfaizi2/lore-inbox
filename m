Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVIUS4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVIUS4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVIUS4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:56:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751001AbVIUS4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:56:30 -0400
Date: Wed, 21 Sep 2005 11:56:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
In-Reply-To: <20050921114533.76815f03.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509211154210.2553@g5.osdl.org>
References: <20050921101558.7ad7e7d7.akpm@osdl.org> <5378.1127211442@warthog.cambridge.redhat.com>
 <12434.1127314090@warthog.cambridge.redhat.com> <5543.1127327394@warthog.cambridge.redhat.com>
 <20050921114533.76815f03.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Sep 2005, Andrew Morton wrote:
> 
> hrmph.  Of course it's a reasonable trick from a performance and
> convenience and resource consumption POV.  But it's a new idiom and the
> threshold for new idioms is non-zero.  We use it in struct page, but struct
> page is special.

Hmm.. I don't feel it is that new, but maybe that's because I've used that 
trick in other places. I think it's pretty common in a "type-safe C" way, 
and it should probably be encouraged. A unique pointer type for special 
usages, that you can't dereference even by mistake..

But adding a few comments might certainly be worth it. If only to teach 
others the trick.

		Linus
