Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVA0MPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVA0MPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVA0MPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:15:38 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15371 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262589AbVA0MPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:15:34 -0500
Subject: Re: A scrub daemon (prezeroing)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 12:15:24 +0000
Message-Id: <1106828124.19262.45.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 12:29 -0800, Christoph Lameter wrote:
> Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> called scrubd. scrubd is disabled by default but can be enabled
> by writing an order number to /proc/sys/vm/scrub_start. If a page
> is coalesced of that order or higher then the scrub daemon will
> start zeroing until all pages of order /proc/sys/vm/scrub_stop and
> higher are zeroed and then go back to sleep.

Some architectures tend to have spare DMA engines lying around. There's
no need to use the CPU for zeroing pages. How feasible would it be for
scrubd to use these?

-- 
dwmw2

