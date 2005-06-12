Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVFLJaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVFLJaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFLJ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:27:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261923AbVFLJ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:27:46 -0400
Date: Sun, 12 Jun 2005 10:27:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] Remove obsolete HAVE_ARCH_GET_SIGNAL_TO_DELIVER?
Message-ID: <20050612092737.GA1206@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <Pine.LNX.4.62.0506121051360.29300@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506121051360.29300@anakin>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:56:26AM +0200, Geert Uytterhoeven wrote:
> 
> Now m68k no longer sets HAVE_ARCH_GET_SIGNAL_TO_DELIVER, can it be removed
> completely? Or may ARM26 still need it? Note that its usage was removed from
> kernel/signal.c about 2 months ago.

oops, I missed the signal.h occurange.  arm26 should definitly not use it,
duplicating that much of the signal code is always a bad idea.

