Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUHPJSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUHPJSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUHPJSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:18:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:16901 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267486AbUHPJRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:17:36 -0400
Date: Mon, 16 Aug 2004 10:17:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040816101732.A9150@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408160038320.9944@skynet>; from airlied@linux.ie on Mon, Aug 16, 2004 at 12:40:43AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 12:40:43AM +0100, Dave Airlie wrote:
> Probably should say PCI APIs properly, it now does enable/disable devices
> and registers the DRM as owning the memory regions, does proper PCI
> probing .. in cases where the fb is loaded on the card already it falls
> back to the old ways (evil direct register writing.. ), this change will
> stop you loading the fb driver adter the drm driver but this shouldn't be
> a common case at all..

Eeek, doing different styles of probing is even worse than what you did
before.  Please revert to pci_find_device() util you havea proper common
driver ready.

