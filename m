Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbRGBWLA>; Mon, 2 Jul 2001 18:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265435AbRGBWKk>; Mon, 2 Jul 2001 18:10:40 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:38323 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261385AbRGBWKb>; Mon, 2 Jul 2001 18:10:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] I/O Access Abstractions
Date: Tue, 3 Jul 2001 00:10:24 +0200
Message-Id: <20010702221024.13080@smtp.wanadoo.fr>
In-Reply-To: <20010702192227.B29246@flint.arm.linux.org.uk>
In-Reply-To: <20010702192227.B29246@flint.arm.linux.org.uk>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Last time I checked, ioremap didn't work for inb() and outb().

ioremap itself cannot work for inb/outb as they are different
address spaces with potentially overlapping addresses, I don't
see how a single function would handle both... except if we
pass it a struct resource instead of the address.

Ben.


