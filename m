Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCTWmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCTWmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCTWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:42:48 -0500
Received: from p3EE066C8.dip.t-dialin.net ([62.224.102.200]:64896 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261320AbVCTWmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:42:20 -0500
Date: Sun, 20 Mar 2005 22:40:29 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Message-ID: <20050320224028.GB6727@linux-mips.org>
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319141351.74f6b2a5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 02:13:51PM -0800, Andrew Morton wrote:

> > au1x00_uart
> > -----------
> > 
> > Maintainer: unknown (akpm - any ideas?)
> 
> Ralf.

Actually Pete Popov (ppopov@embeddedalley.com) who I put on the cc.

> > This is a complete clone of 8250.c, which includes all the 8250-specific
> > structure names.
> > 
> > Specifically, I'd like to see the following addressed:
> > 
> > - Please clean this up to use au1x00-specific names.
> > - this driver is lagging behind with fixes that the other drivers are
> >   getting.  Is au1x00_uart actually maintained?

Sort of; much of the Alchemy development effort is still going into 2.4.

> > - the usage of UPIO_HUB6
> >   (this driver doesn't support hub6 cards)
> > - __register_serial, register_serial, unregister_serial
> >   (this driver doesn't support PCMCIA cards, all of which are based on
> >    8250-compatible devices.)
> > - early_serial_setup
> >   (should we really have the function name duplicated across different
> >    hardware drivers?)

No argument here.  Pete says the AMD Alchemy UART is just different enough
to be hard to handle in the 8250 and so the driver is just an ugly
chainsawed version of the 8250.c

> > The main reason is I wish to kill off uart_register_port and
> > uart_unregister_port, but these drivers are using it.

  Ralf
