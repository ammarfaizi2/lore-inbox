Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVDMPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVDMPDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVDMPDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:03:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39179 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261365AbVDMPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:02:52 -0400
Date: Wed, 13 Apr 2005 16:02:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc2-mm3] serial: update NEC VR4100 series serial support
Message-ID: <20050413160248.A19329@flint.arm.linux.org.uk>
Mail-Followup-To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050413231827.11799413.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050413231827.11799413.yuasa@hh.iij4u.or.jp>; from yuasa@hh.iij4u.or.jp on Wed, Apr 13, 2005 at 11:18:27PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:18:27PM +0900, Yoichi Yuasa wrote:
>  static struct uart_ops early_uart_ops = {
> -	.set_termios	= early_set_termios,
> +	.set_termios	= siu_set_termios,
>  };

In this case, you don't need the early_uart_ops here - the standard
ones will do just as well.  (.set_termios is the only method which
the console init code will use.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
