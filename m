Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVHHVyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVHHVyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVHHVyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:54:04 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:925 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932280AbVHHVyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:54:03 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Mon, 8 Aug 2005 23:53:53 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [SLAB] __builtin_return_address use without FRAME_POINTER causes boot failure
Message-ID: <20050808215353.GA26384@localhost.localdomain>
References: <Pine.LNX.4.62.0508081353170.28612@graphe.net> <42F7D08E.9070508@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F7D08E.9070508@colorfullife.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 11:37:18PM +0200 Manfred Spraul wrote:

> Christoph Lameter wrote:
> 
> >I kept getting boot failures in the slab allocator. The failure goes 
> >away if one is setting CONFIG_FRAME_POINTER. Seems that 
> >CONFIG_DEBUG_SLAB implies the use of __buildin_return_address() which 
> >needs the framepointer.
> >
> > 
> >
> Very odd. __builtin_return_address(1) needs frame pointers, but slab 
> only uses __builtin_return_addresse(0), which should always work.
> 

My fault, I introduced a debugging patch (i think i cc'ed you on it)
which used __builtin_return_address([12]) to save traces of who the
caller of an object is.
