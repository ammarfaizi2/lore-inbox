Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVK3P1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVK3P1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVK3P1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:27:21 -0500
Received: from kanga.kvack.org ([66.96.29.28]:18049 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751270AbVK3P1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:27:20 -0500
Date: Wed, 30 Nov 2005 10:24:35 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130152435.GC23308@kvack.org>
References: <20051130042118.GA19112@kvack.org> <20051130151847.GE5706@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130151847.GE5706@mea-ext.zmailer.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 05:18:47PM +0200, Matti Aarnio wrote:
> I would rather prefer NOT to introduce this at this time.
> My primary concern is that during "even numbered series" there
> should not be radical internal ABI/API changes, like this one.

Any modules built by the official Makefile method will atomatically 
pick up the necessary changes to the compiler flags, and the ABI 
presented to userspace is unchanged.

Also, part of the patch series is needed in order to introduce colouring 
of the kernel stack (namely divorcing the relationship of thread_info 
with the stack pointer).

> In 2.7 it can be introduced, by all means.

As far as I am aware, there is no plan for a 2.7 at this time.

> Indeed at the moment my thinking is, that X86-64 is way more UNSTABLE,
> than it should be.  (And Linux kernel overall, but that is another story.)

At least I found one problem that was impacting the boot stability of my 
test box, so it can't all be bad. =-)

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
