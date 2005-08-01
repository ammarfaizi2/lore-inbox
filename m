Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVHAIxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVHAIxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVHAIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:53:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:27799 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261770AbVHAIxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:53:42 -0400
Subject: Re: revert yenta free_irq on suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: abelay@novell.com
Cc: Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
References: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 10:49:48 +0200
Message-Id: <1122886189.18835.109.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 23:03 -0400, ambx1@neo.rr.com wrote:

> Also, as I said earlier, the better we support OSPM initiated power
> management, the more likely APM will break.  This may be technically
> unavoidable on some isolated boxes without quirks.  I agree with
> Pavel that "do nothing" may make sense, but it seems some devices
> may still need to be disabled by the OS.  As a real world example,
> we currently can't turn off cardbus bridges because it breaks APM
> on a couple of older laptops.

Won't freeing of IRQs cause problems with things like handhelds that
actually rely on an interrupt to wake up ?

Ben.


