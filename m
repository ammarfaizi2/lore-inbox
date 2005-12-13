Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVLMWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVLMWVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVLMWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:21:13 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:23677 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030275AbVLMWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:21:13 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [spi-devel-general] [patch 2.6.15-rc5-mm2] SPI, priority inversion tweak
Date: Tue, 13 Dec 2005 14:21:09 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
References: <200512131028.49291.david-b@pacbell.net> <439F4206.2040406@ru.mvista.com>
In-Reply-To: <439F4206.2040406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131421.10231.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 1:49 pm, Vitaly Wool wrote:
> So you're turning this to be unsafe if the buffer is in use, right? Funny...

I have no idea what you mean by that comment.  The parameters to that
function have always been documented as "will copy", and the two branches
(busy/not) differ only in _which_ buffer they use from the heap (the
fast pre-allocated one, or a freshly allocated scratch buffer).  Heap
buffers are by definition DMA-safe.

- Dave


> David Brownell wrote:
> 
> >This is an updated version of the patch from Mark Underwood, handling
> >the no-memory case better and using SLAB_KERNEL not SLAB_ATOMIC.
> >
> 
