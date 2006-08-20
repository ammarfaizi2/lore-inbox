Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWHTSQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWHTSQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHTSQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:16:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8415 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751022AbWHTSQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:16:15 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820181025.GN602@1wt.eu>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com>
	 <1156097013.4051.14.camel@localhost.localdomain>
	 <20060820181025.GN602@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:36:46 +0100
Message-Id: <1156099006.4051.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 20:10 +0200, ysgrifennodd Willy Tarreau:
> So I think that while it's bad code in userland, a misunderstood kernel
> semantic caught the developpers. We can at least make the kernel help them.

Yeah we could. But unfortunately a competence test with the inability to
write C code isn't part of the Unix spec.

You can help them enormously using the gcc extensions so gcc warns about
any unchecked set*uid call, rather than redesigning expected behaviour
to cause obscure random kills that won't even be noticed/explained.

