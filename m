Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVAIUDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVAIUDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAIUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:03:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29958 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261734AbVAIUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:03:05 -0500
Date: Sun, 9 Jan 2005 20:03:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050109200301.B12788@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <20050109192305.GA7476@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050109192305.GA7476@infradead.org>; from arjan@infradead.org on Sun, Jan 09, 2005 at 07:23:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 07:23:05PM +0000, Arjan van de Ven wrote:
> Nothing in the kernel is using bcopy right know, and that is a good thing.
> Why? Because a lot of the architectures implement a broken bcopy()....
> the userspace standard bcopy() is basically a memmove() with a weird
> parameter order, however a bunch of architectures implement a memcpy() not a
> memmove(). 

ARM doesn't implement bcopy() but does define __HAVE_ARCH_BCOPY - so
any users would error.  Removing bcopy() is therefore no problem
afaics, and I'll lend my support by trying to will it to be gone. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
