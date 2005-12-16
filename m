Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLPErw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLPErw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVLPErw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:47:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:14013 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932122AbVLPErw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:47:52 -0500
Subject: Re: [BUG] Xserver startup locks system... git bisect results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051216035032.GA4026@jupiter.solarsys.private>
References: <20051215043212.GA4479@jupiter.solarsys.private>
	 <1134622384.16880.26.camel@gaston> <1134623242.16880.30.camel@gaston>
	 <1134623748.16880.32.camel@gaston>
	 <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
	 <20051216035032.GA4026@jupiter.solarsys.private>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 15:43:10 +1100
Message-Id: <1134708190.16880.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 22:50 -0500, Mark M. Hoffman wrote:

> I added the printk's you (BH) asked for to Paul's patch, resulting in the
> patch below.  It works fine so far.  Here's the relevant kernel log:

Ok, sounds good, it's also the right way to go. However, Linus, don't
merge that patch "as-is" as some chips have a bug with CONFIG_MEMSIZE
being 0 instead of 8k. I'll send you a proper patch and I'll fix the
remaining problems on X side (it's still bogus, though the DRM "fixes it
up" now).

Ben.


