Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVHRAjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVHRAjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVHRAjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:39:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751321AbVHRAjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:39:51 -0400
Date: Wed, 17 Aug 2005 17:38:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
Message-Id: <20050817173818.098462b5.akpm@osdl.org>
In-Reply-To: <20050810.133125.08323684.davem@davemloft.net>
References: <20050810200216.644997000@jumble.boston.redhat.com>
	<20050810200943.809832000@jumble.boston.redhat.com>
	<20050810.133125.08323684.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> > +DEFINE_PER_CPU(unsigned long, evicted_pages);
> 
> DEFINE_PER_CPU() needs an explicit initializer to work
> around some bugs in gcc-2.95, wherein on some platforms
> if you let it end up as a BSS candidate it won't end up
> in the per-cpu section properly.
> 
> I'm actually happy you made this mistake as it forced me
> to audit the whole current 2.6.x tree and there are few
> missing cases in there which I'll fix up and send to Linus.

I'm prety sure we fixed that somehow.  But I forget how.
