Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUFUHfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUFUHfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUFUHfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:35:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:65237 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266138AbUFUHfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:35:10 -0400
X-Authenticated: #12437197
Date: Mon, 21 Jun 2004 10:36:44 +0300
From: Dan Aloni <da-x@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-ID: <20040621073644.GA10781@callisto.yi.org>
Reply-To: Dan Aloni <da-x@colinux.org>
References: <20040621063845.GA6379@callisto.yi.org> <20040620235824.5407bc4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620235824.5407bc4c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:58:24PM -0700, Andrew Morton wrote:
> Dan Aloni <da-x@gmx.net> wrote:
> >
> > The rest of the kernel treats tty->driver->chars_in_buffer as a possible
> >  NULL. This patch changes normal_poll() to be consistent with the rest of
> >  the code.
> 
> It would be better to change the rest of the kernel - remove the tests.
> 
> If any driver fails to implement ->chars_in_buffer() then we get a nice
> oops which tells us that driver needs a stub handler.

Are you sure that it won't affect the logic in tty_wait_until_sent() 
drastically? It acts quite differently when ->chars_in_buffer == NULL.

-- 
Dan Aloni
da-x@colinux.org
