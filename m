Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFFLLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFFLLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFFLLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:11:50 -0400
Received: from animx.eu.org ([216.98.75.249]:184 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261293AbVFFLLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:11:48 -0400
Date: Mon, 6 Jun 2005 07:07:43 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606110743.GA23107@animx.eu.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20050605223528.GA13726@alpha.home.local> <20050606010246.GA22252@animx.eu.org> <20050606041101.GA14799@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606041101.GA14799@alpha.home.local>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep me CC.

Willy Tarreau wrote:
> On Sun, Jun 05, 2005 at 09:02:46PM -0400, Wakko Warner wrote:
> > Is it any smaller than a UPX'd kernel?  (I think you need the beta version. 
> > I know the upx-ucl in debian won't compress but upx-ucl-beta will if you
> > force).  I got a significant reduction using it.
> 
> It's not better at all, but unfortunately, UPX cannot compress a kernel which
> embeds a big initramfs. The problem is that the compressed initramfs is
> embedded into vmlinux, which is then compressed into bzImage, and UPX only
> replaces the bzImage compression.
> 
> May be it would work if we did not compress the initramfs before including
> it into the vmlinux.

My initramfs is passed via initrd so that I can change any aspect of it with
out recompiling the kernel (or maybe i could use a better understanding of
initramfs)  I compared bzImage to bupxImage and the savings I got was around
50kb difference IIRC.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
