Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVKBH0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVKBH0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVKBH0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:26:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:7339 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932619AbVKBH0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:26:20 -0500
Subject: [PATCH] ppc64: 64K pages support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1130915220.20136.14.camel@gaston>
References: <1130915220.20136.14.camel@gaston>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 18:23:18 +1100
Message-Id: <1130916198.20136.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 18:07 +1100, Benjamin Herrenschmidt wrote:
> It took a while, but finally, here is the 64K pages support patch for
> ppc64. This patch adds a new CONFIG_PPC_64K_PAGES which, when enabled,
> changes the kernel base page size to 64K. The resulting kernel still
> boots on any hardware. On current machines with 4K pages support only,
> the kernel will maintain 16 "subpages" for each 64K page
> transparently.
> 
> Note that while real 64K capable HW has been tested, the current patch
> will not enable it yet as such hardware is not released yet, and I'm
> still verifying with the firmware architects the proper to get the
> information from the newer hypervisors.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Oh, and since the mailing lists are probably filtering this out due to
the patch size, here's an URL where you can find it too:

http://gate.crashing.org/~benh/ppc64-64k-pages.diff

Ben.


