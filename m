Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbULROvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbULROvK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULROvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:51:10 -0500
Received: from [213.146.154.40] ([213.146.154.40]:60385 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261158AbULROvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:51:05 -0500
Date: Sat, 18 Dec 2004 14:51:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041218145104.GA7669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <200412162224.iBGMOQ52284713@fsgi900.americas.sgi.com> <20041216231519.GA16249@infradead.org> <41C35A45.7090206@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C35A45.7090206@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure what you mean here. I don't have an entry for ->remove and the 
> driver is self-contained.

In a PCI driver (well, just about any driver for a modern bus) you have
an probe and an remove entry.  All code to setup and teardown a device must
happen in those functions, and must not use global state but only the device
instance pointers. 

btw, no need to Cc linux-ia64, there's nothing ia64-specific in this driver.
