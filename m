Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTACGoE>; Fri, 3 Jan 2003 01:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTACGoE>; Fri, 3 Jan 2003 01:44:04 -0500
Received: from holomorphy.com ([66.224.33.161]:15304 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267440AbTACGoD>;
	Fri, 3 Jan 2003 01:44:03 -0500
Date: Thu, 2 Jan 2003 22:52:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Brownell <david-b@pacbell.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Message-ID: <20030103065220.GA9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Brownell <david-b@pacbell.net>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200301022207.OAA00803@adam.yggdrasil.com> <3E1531D3.3070809@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1531D3.3070809@pacbell.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
>>	mempool_alloc does.  That's the point of it.  You calculate
>> how many objects you need in order to guarantee no deadlocks and
>> reserve that number in advance (the initial reservation can fail).

On Thu, Jan 02, 2003 at 10:46:43PM -0800, David Brownell wrote:
> To rephrase that so it illustrates my point:  the whole reason to
> use mempool is to try adding __GFP_NEVERFAIL when __GFP_WAIT is
> given ... because __GFP_WAIT doesn't otherwise mean NEVERFAIL.

Well, it's not quite that general. There is a constraint of the
objects allocated with a mempool having a finite lifetime. And
non-waiting mempool allocations are also available, but may fail.

So long as the queueing is fair everyone eventually gets their turn.


Bill
