Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUFOVRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUFOVRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUFOVRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:17:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9479 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265960AbUFOVRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:17:38 -0400
Date: Tue, 15 Jun 2004 22:17:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615221734.J7666@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk> <20040615085952.GA19197@infradead.org> <20040615210739.GM2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615210739.GM2310@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Jun 15, 2004 at 11:07:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 11:07:39PM +0200, Sam Ravnborg wrote:
> Better make life easier - but in a nice and structured way.

Life /was/ easy when there was just zImage and Image on ARM.  All you
had to do was decide whether you wanted a compressed or uncompressed
binary image of the kernel, where compressed images were the normal.

And this is the way I'd preferred it to stay since we have a nice
sane structured idea of what we provide without any major "what
file format do I need" problems.

The problem starts happening when boot loaders think they can dictate
to the kernel what format they want the kernel to be in - at that
point the number of kernel image formats and methods to boot the
kernel increases and everything gets a lot more complex.

This is the whole basis of my argument.  We shouldn't make it easy
for people to extend this stupid idea that the boot loader defines
the format which the kernel shall be in.  It's the _wrong_ idea.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
