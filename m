Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVAPPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVAPPrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVAPPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:47:40 -0500
Received: from verein.lst.de ([213.95.11.210]:54497 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261395AbVAPPrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:47:33 -0500
Date: Sun, 16 Jan 2005 16:47:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: bunk@stusta.de, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix CONFIG_AGP depencies
Message-ID: <20050116154723.GA16449@lst.de>
References: <200501161537.j0GFbWE3028005@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501161537.j0GFbWE3028005@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 04:37:32PM +0100, Mikael Pettersson wrote:
> You're preventing the ppc64 kernel for Apple PowerMac G5s
> from including AGP support via CONFIG_AGP_UNINORTH. I doubt
> that's correct.

It is correct.  In mainline AGP for the G5 isn't supported at all.
On linuxppc64-dev there's a patch to support it on ppc32, but more
work is required to make it work with ppc64.  Once that's done
the depency can be updated.  Currently agp doesn't even compile
on ppc64 due to a lacking <asm/agp.h> as I mentioned in the first
mail.
