Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268476AbUHLJPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbUHLJPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHLJPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:15:17 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:16911 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268476AbUHLJPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:15:09 -0400
Date: Thu, 12 Aug 2004 10:15:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
Message-ID: <20040812101507.C5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <411AAABB.8070707@sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:24:43PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:24:43PM -0500, Patrick Gefre wrote:
> This is a very BIG change.  However, the BIG change ends up with
> very little code in the kernel.  The reason is because, we have enhanced the
> functionalities in our Prom to actually configure and initialize all devices
> in the system instead of just the BaseIO devices.

Surely it can be spit out.  E.g. hwgraph removal is separate from your
SAL call stuff which is separate from dma mapping.

And,  let me repeat:

     There is absolutely _NO_ interest in adding yet another non-standard
     prom interface for PCI configuration.  IA64 has a standard ACPI-based
     interface that everyone but SGI implementent.  Please implement that one
     in your firmware.

> We do like our directory structures.  It provides very logical
> separation of code files.

You have more subdirectories than everything else in arch/ia64/ combined,
go figure. 

