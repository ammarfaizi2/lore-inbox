Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWD1FjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWD1FjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWD1FjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:39:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030234AbWD1FjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:39:21 -0400
Date: Thu, 27 Apr 2006 22:39:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/4] i386: Fix overflow in e820_all_mapped
In-Reply-To: <4451A80E.mailNZX1XN4A8@suse.de>
Message-ID: <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
References: <4451A80E.mailNZX1XN4A8@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Andi Kleen wrote:
> 
> The 32bit version of e820_all_mapped() needs to use u64 to avoid
> overflows on PAE systems.  Pointed out by Jan Beulich

I don't think that's true.

It can't be called with 64-bit arguments anyway. If the base address 
doesn't fit in 32-bit, we'd be screwed in other places, afaik.

		Linus
