Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVHHVxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVHHVxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHHVxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:53:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932278AbVHHVxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:53:10 -0400
Date: Mon, 8 Aug 2005 14:51:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: christoph@lameter.com, linux-kernel@vger.kernel.org
Subject: Re: [SLAB] __builtin_return_address use without FRAME_POINTER
 causes boot failure
Message-Id: <20050808145143.01b70183.akpm@osdl.org>
In-Reply-To: <42F7D08E.9070508@colorfullife.com>
References: <Pine.LNX.4.62.0508081353170.28612@graphe.net>
	<42F7D08E.9070508@colorfullife.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
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

I assume this is due to the now-dropped
slab-leak-detector-give-longer-traces.patch
