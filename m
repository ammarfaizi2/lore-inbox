Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVAIUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVAIUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVAIUfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:35:25 -0500
Received: from [213.146.154.40] ([213.146.154.40]:42975 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261759AbVAIUfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:35:05 -0500
Date: Sun, 9 Jan 2005 20:34:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050109203459.GA28788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:19:09PM -0800, Linus Torvalds wrote:
> The problem is that at least some gcc versions would historically generate
> calls to "bcopy" on alpha for structure assignments. Maybe it doesn't any
> more, and no such old gcc versions exist any more, but who knows?

We're building with -ffreestanding now, so gcc isn't allowed to emit
any calls to standard library functions.

