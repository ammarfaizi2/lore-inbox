Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWGNUTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWGNUTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWGNUTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:19:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422761AbWGNUTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:19:54 -0400
Date: Fri, 14 Jul 2006 21:19:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jim Gifford <maillist@jg555.com>, LKML <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060714201951.GA25159@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jim Gifford <maillist@jg555.com>,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
References: <44B443D2.4070600@jg555.com> <1152836749.31372.36.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152836749.31372.36.camel@shinybook.infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 01:25:48AM +0100, David Woodhouse wrote:
> On Tue, 2006-07-11 at 17:35 -0700, Jim Gifford wrote:
> > I will only document one issue, but there are several more like this
> > in the kernel.
> 
> Please elaborate, preferably in 'diff -u' form as below...
> 
> > I'm going to use the MIPS architecture in my example, along with the 
> > file page.h. 
> 
> [PATCH] Reduce user-visible noise in asm-mips/page.h

The right fix is to not expose page.h at all on any architecture.  There's
nothing userspace should care about in this file.

