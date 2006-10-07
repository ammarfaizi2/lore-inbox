Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWJGBQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJGBQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 21:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWJGBQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 21:16:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422822AbWJGBQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 21:16:54 -0400
Date: Fri, 6 Oct 2006 18:16:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>,
       "Michael H. Warfield" <mhw@wittsend.com>
Subject: Re: [PATCH] Char: remove unneded termbits redefinitions
Message-Id: <20061006181641.e437548e.akpm@osdl.org>
In-Reply-To: <1236876321987@karneval.cz>
References: <1236876321987@karneval.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Oct 2006 18:49:01 +0200 (CEST)
Jiri Slaby <jirislaby@gmail.com> wrote:

> Char, remove unneded termbits redefinitions
> 
> No need to redefine termbits in char tree.

drivers/char/ip2/ip2main.c:2498: error: 'B153600' undeclared (first use in this function)
drivers/char/ip2/ip2main.c:2498: error: (Each undeclared identifier is reported only once
drivers/char/ip2/ip2main.c:2498: error: for each function it appears in.)
drivers/char/ip2/ip2main.c:2500: error: 'B307200' undeclared (first use in this function)

Unless you're a sparc user, methinks you didn't compile this one.

I suppose an appropriate fix would be to move the B153600 and B307200
definitions into include/asm-*/termbits.h (those which don't already have it).
But that's just a guess.

