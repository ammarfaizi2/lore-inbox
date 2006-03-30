Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWC3USB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWC3USB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWC3USB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:18:01 -0500
Received: from ns.suse.de ([195.135.220.2]:64688 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750799AbWC3USA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:18:00 -0500
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] ioremap_cached()
Date: Thu, 30 Mar 2006 22:17:55 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060330164120.GJ13590@parisc-linux.org> <200603302150.05357.ak@suse.de> <20060330201435.GM13590@parisc-linux.org>
In-Reply-To: <20060330201435.GM13590@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603302217.55435.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 22:14, Matthew Wilcox wrote:

> I think you misunderstood.  The right interface to call, that should
> work everywhere, should be the simple, obvious one.  ioremap().  That
> effectively is what everyone gets anyway (since they test on x86).
> So change the *definition* of ioremap() to be uncached.  Then we can add
> ioremap_wc() and ioremap_cached() for these special purpose mappings.

That would break all the current users who do ioremap on memory
and want it cached.

-Andi
