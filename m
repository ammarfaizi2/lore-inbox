Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUFAN5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUFAN5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUFAN5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:57:43 -0400
Received: from [213.146.154.40] ([213.146.154.40]:37857 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265055AbUFAN5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:57:41 -0400
Date: Tue, 1 Jun 2004 14:57:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601135737.GA18989@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040601102928.GA16718@infradead.org> <16572.34833.366022.48748@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16572.34833.366022.48748@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 03:43:45PM +0200, Mikael Pettersson wrote:
> Been there, done that. open() on /proc/{$pid,self}/perfctr with
> or without O_CREAT was the "get initial access" interface for
> several years, until the semantics of /proc/$pid (and /proc/self)
> completely changed in 2.6.0-test6.
> 
> Virtual perfctrs wants something that denotes the real kernel
> task, not that process-is-a-group-of-kernel-threads crap.

I'm not on a nptl system here, so no thread groups in use, but don't
we have /proc/$pid/$tid/ now?

And yes, I agree with you that the change was utter crap, still wondering
how it went in without proper review.
