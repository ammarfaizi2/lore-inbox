Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVAIXjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVAIXjG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVAIXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 18:39:06 -0500
Received: from are.twiddle.net ([64.81.246.98]:28800 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261976AbVAIXjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 18:39:03 -0500
Date: Sun, 9 Jan 2005 15:38:52 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050109233852.GA23256@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:19:09PM -0800, Linus Torvalds wrote:
> Gcc _used_ to have a target-specific "do I use bcopy or memcpy" setting,
> and I just don't know if that is still true.

Yes, TARGET_MEM_FUNCTIONS.  It's never not set for Linux targets.
Or for OSF/1 for that matter...  Indeed, it would take me some time
to figure out which targets it's *not* set for.

(Yet another thing that ought to get cleaned up -- either invert the
default value or simply require the target to either provide the libc
entry point or add a version to libgcc.)

I'm not sure how far back you'd have to go to find an Alpha compiler
that needs this.  Prolly back to at least gcc 2.6, but I don't have
sources that old handy to check.



r~
