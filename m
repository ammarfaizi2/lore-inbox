Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUFUG7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUFUG7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUFUG7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:59:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:44957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266133AbUFUG7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:59:46 -0400
Date: Sun, 20 Jun 2004 23:58:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dan Aloni <da-x@colinux.org>
Cc: da-x@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-Id: <20040620235824.5407bc4c.akpm@osdl.org>
In-Reply-To: <20040621063845.GA6379@callisto.yi.org>
References: <20040621063845.GA6379@callisto.yi.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@gmx.net> wrote:
>
> The rest of the kernel treats tty->driver->chars_in_buffer as a possible
>  NULL. This patch changes normal_poll() to be consistent with the rest of
>  the code.

It would be better to change the rest of the kernel - remove the tests.

If any driver fails to implement ->chars_in_buffer() then we get a nice
oops which tells us that driver needs a stub handler.
