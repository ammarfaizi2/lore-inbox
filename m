Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWHUB5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWHUB5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWHUB5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:57:09 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:27277 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751803AbWHUB5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:57:07 -0400
Date: Sun, 20 Aug 2006 21:55:17 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060821015517.GA22062@ccure.user-mode-linux.org>
References: <20060819073031.GA25711@atjola.homenet> <200608201237.13194.chase.venters@clientec.com> <20060820112523.f14fc6dc.akpm@osdl.org> <200608201333.02951.chase.venters@clientec.com> <20060820194552.GB11843@atjola.homenet> <1156103446.23756.60.camel@laptopd505.fenrus.org> <20060820201118.GC11843@atjola.homenet> <1156105229.23756.65.camel@laptopd505.fenrus.org> <20060820203604.GD11843@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820203604.GD11843@atjola.homenet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:36:04PM +0200, Bj?rn Steinbrink wrote:
> For example check_host_supports_tls in arch/um/os-Linux/sys-i386/tls.c
> which even uses the global errno (although in that case the whole
> else part could probably be just removed).

UML is different.  It uses errno extensively (as it must) on the glibc side
of things.  On the kernel side, there are no uses of errno that I'm aware of.

				Jeff
