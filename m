Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUAZKcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbUAZKcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:32:39 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:33552 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265539AbUAZKci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:32:38 -0500
Date: Mon, 26 Jan 2004 10:32:37 +0000
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oprofile per-cpu buffer overrun
Message-ID: <20040126103237.GA52771@compsoc.man.ac.uk>
References: <20040126023715.GA3166@zaniah> <20040125200701.3c7b769a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125200701.3c7b769a.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Al42n-000K5U-Ln*e89ZIrnWKGM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 08:07:01PM -0800, Andrew Morton wrote:

> When implementing a circular buffer it is better to not constrain the head
> and tail indices - just let them grow and wrap without bound.  You only need
> to bring them in-bounds when you actually use them to index the buffer.

I'm not sure why that's better.

> - head-tail is always the amount of used space, no need to futz around
>   handling the case where one has wrapped and the other hasn't.

I admit I have a hangover, but it seems to me it would actually be more
complicated to make damn sure that the integer overflow case is
definitely handled properly.

I clearly can't write functioning ring buffers :), so I'd prefer it to
stay as simple as possible.

regards,
john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
