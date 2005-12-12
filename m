Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLLR5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLLR5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVLLR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:57:35 -0500
Received: from hera.kernel.org ([140.211.167.34]:20109 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932102AbVLLR5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:57:34 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 5/9] isdn4linux: Siemens Gigaset drivers - tty interface
Date: Mon, 12 Dec 2005 09:57:30 -0800
Organization: OSDL
Message-ID: <20051212095730.55c44081@unknown-222.office.pdx.osdl.net>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.3@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.4@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1134410251 15375 10.8.0.222 (12 Dec 2005 17:57:31 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 12 Dec 2005 17:57:31 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2005 19:20:38 +0100
Hansjoerg Lipp <hjlipp@web.de> wrote:

> From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
> 
> This patch adds the tty interface to the gigaset module.
> The tty interface provides direct access to the AT command set of the
> Gigaset devices.
> 
> Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
> Signed-off-by: Tilman Schmidt <tilman@imap.cc>
> ---
> 
> +static struct tty_operations if_ops = {
> +	.open =			if_open,
> +	.close =		if_close,
> +	.ioctl =		if_ioctl,
> +	.write =		if_write,
> +	.write_room =		if_write_room,
> +	.chars_in_buffer =	if_chars_in_buffer,
> +	.set_termios =		if_set_termios,
> +	.throttle =		if_throttle,
> +	.unthrottle =		if_unthrottle,
> +#if 0
> +	.break_ctl =		serial_break,
> +#endif
> +	.tiocmget =		if_tiocmget,
> +	.tiocmset =		if_tiocmset,
> +};

Missing .owner = THIS_MODULE

