Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSKDVHG>; Mon, 4 Nov 2002 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKDVHG>; Mon, 4 Nov 2002 16:07:06 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26616 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262789AbSKDVHD>;
	Mon, 4 Nov 2002 16:07:03 -0500
Date: Mon, 4 Nov 2002 13:11:58 -0800
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
Message-ID: <20021104211158.GA8382@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <7312677.1036269363155.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7312677.1036269363155.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 12:36:03PM -0800, ALESSANDRO.SUARDI wrote:
> 
> while a substantially lower amount of spam under 2.4 tells me
> 
> Nov  2 21:28:31 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> Nov  2 21:28:31 dolphin kernel: irda0: transmit timed out
> Nov  2 21:28:38 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> Nov  2 21:28:38 dolphin kernel: irda0: transmit timed out
> Nov  2 21:29:05 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> Nov  2 21:29:05 dolphin kernel: irda0: transmit timed out

	Yep, I have the same problem when I try irport. It seems that
somehow we drop/miss a Tx-done interrupt (UART_IIR_THRI). I tried to
investigate that but came empty handed.
	I looked a the new smsc-ircc2 driver, and I suspect that what
you see is another manifestation of the exact same problem.

> Thanks for now & ciao,
> 
> --alessandro

	Have fun...

	Jean
