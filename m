Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGLV7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGLV7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGLV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:58:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13580 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263806AbUGLVz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:55:58 -0400
Date: Mon, 12 Jul 2004 22:55:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Update pcips2 driver
Message-ID: <20040712225550.B15469@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20040712154207.A15469@flint.arm.linux.org.uk> <20040712132525.550bcebb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040712132525.550bcebb.akpm@osdl.org>; from akpm@osdl.org on Mon, Jul 12, 2004 at 01:25:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 01:25:25PM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > Use pci_request_regions()/pci_release_regions() instead of
> > request_region()/release_region()
> 
> Some of this patch is already in Vojtech's tree.  If it's not critical,
> perhaps it would be best if he took the remaining bit:

Looking at the bits in the 2.6.7-mm7 tree, none of my original patch
is merged, and merging the bit below would mean that we then have an
asymetry between the function used to request the resources and the
function used to release them.

Therefore, I think the original patch should stand as-is.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
