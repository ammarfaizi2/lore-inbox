Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVHXJWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVHXJWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVHXJWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:22:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750811AbVHXJWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:22:51 -0400
Date: Wed, 24 Aug 2005 10:22:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] #include <asm/irq.h> in interrupt.h
Message-ID: <20050824092250.GA26726@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050824085750.GG5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824085750.GG5603@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 10:57:50AM +0200, Adrian Bunk wrote:
> If #includ'ing interrupt.h should be enough for getting the prototype of 
> e.g. enable_irq() on all architectures, we need this patch.

Per defintion you need to include <asm/irq.h> right now.  I'd like to change
that to <linux/interrupt.h>, but not my including <asm/irq.h> there.
We should just make the prototypes in <linux/interrupt.h> unconditional
and get rid of the macro/inline tricks some architectures do, these calls
aren't exactly fastpathes where that matters.

