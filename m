Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264171AbTIJAxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTIJAxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:53:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:25483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264171AbTIJAxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:53:44 -0400
Date: Tue, 9 Sep 2003 17:35:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: khromy@lnuxlab.ath.cx (khromy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_control/bulk_msg: timeout / NETDEV WATCHDOG: eth0: transmit
 timed out
Message-Id: <20030909173558.3a563022.akpm@osdl.org>
In-Reply-To: <20030910002720.GA30861@lnuxlab.ath.cx>
References: <20030910002720.GA30861@lnuxlab.ath.cx>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy@lnuxlab.ath.cx (khromy) wrote:
>
> Anybody know what's up with this?  Running 2.4.23-pre3 I get the following 
> while booting up:
> 
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=3 (error=-110)
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e601.
>   diagnostics: net 0cc0 media 88c0 dma 0000003b.
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?

I'd be suspecting ACPI changes broke the IRQ routing to the network card.

Try disabling ACPI.

