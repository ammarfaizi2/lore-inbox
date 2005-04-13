Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVDMXMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDMXMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVDMXMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:12:47 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:34550 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261220AbVDMXMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:12:36 -0400
Date: Thu, 14 Apr 2005 08:12:12 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc2-mm3] serial: update NEC VR4100 series serial
 support
Message-Id: <20050414081212.744a1175.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050413160248.A19329@flint.arm.linux.org.uk>
References: <20050413231827.11799413.yuasa@hh.iij4u.or.jp>
	<20050413160248.A19329@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 16:02:48 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Apr 13, 2005 at 11:18:27PM +0900, Yoichi Yuasa wrote:
> >  static struct uart_ops early_uart_ops = {
> > -	.set_termios	= early_set_termios,
> > +	.set_termios	= siu_set_termios,
> >  };
> 
> In this case, you don't need the early_uart_ops here - the standard
> ones will do just as well.  (.set_termios is the only method which
> the console init code will use.)

First, I tested the standerd ops. kernel was crashed.
Now, I'm using early_uart_ops.

I'll test again with standerd ops.

Thanks,

Yoichi
