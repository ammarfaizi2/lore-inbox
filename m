Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVBBVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVBBVpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVBBVm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:42:57 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:7635 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262591AbVBBVkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:40:05 -0500
Subject: Re: A scrub daemon (prezeroing)
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050202163110.GB23132@logos.cnet>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	 <1106828124.19262.45.camel@hades.cambridge.redhat.com>
	 <20050202153256.GA19615@logos.cnet>
	 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
	 <20050202163110.GB23132@logos.cnet>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 21:39:54 +0000
Message-Id: <1107380394.18239.34.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 14:31 -0200, Marcelo Tosatti wrote:
> Someone should try implementing the zeroing driver for a fast x86 PCI
> device. :)

The BT848/BT878 seems like an ideal candidate. That kind of abuse is
probably only really worth it on an architecture with cache-coherent DMA
though. If you have to flush the cache anyway, you might as well just
zero it from the CPU.

-- 
dwmw2


