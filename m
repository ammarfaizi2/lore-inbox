Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVA0NMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVA0NMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVA0NMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:12:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61916 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262610AbVA0NMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:12:41 -0500
Date: Thu, 27 Jan 2005 07:12:29 -0600
From: Robin Holt <holt@sgi.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: A scrub daemon (prezeroing)
Message-ID: <20050127131228.GB31288@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com> <1106828124.19262.45.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106828124.19262.45.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 12:15:24PM +0000, David Woodhouse wrote:
> On Fri, 2005-01-21 at 12:29 -0800, Christoph Lameter wrote:
> > Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> > called scrubd. scrubd is disabled by default but can be enabled
> > by writing an order number to /proc/sys/vm/scrub_start. If a page
> > is coalesced of that order or higher then the scrub daemon will
> > start zeroing until all pages of order /proc/sys/vm/scrub_stop and
> > higher are zeroed and then go back to sleep.
> 
> Some architectures tend to have spare DMA engines lying around. There's
> no need to use the CPU for zeroing pages. How feasible would it be for
> scrubd to use these?

An earlier proposal that Christoph pushed would have used the BTE on
sn2 for this.  Are you thinking of using the BTE on sn0/sn1 mips?

Robin
