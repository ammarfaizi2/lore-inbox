Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVHUWSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVHUWSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHUWR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:17:59 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:64949 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1751195AbVHUWR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:17:59 -0400
Date: Sun, 21 Aug 2005 15:17:39 -0700
From: David Hinds <dhinds@sonic.net>
To: "Hesse, Christian" <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: IRQ problem with PCMCIA
Message-ID: <20050821221739.GA18925@sonic.net>
References: <200508212043.58331.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508212043.58331.mail@earthworm.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 08:43:50PM +0200, Hesse, Christian wrote:
> Hello everybody,
> 
> seems like I have a problem with PCMCIA/PCCARD. If I transfer data
> to or from a CF card inserted via adapter system waits for
> interrupts most of the time: Cpu(s): 21.2% us, 7.9% sy, 0.0% ni,
> 0.0% id, 1.7% wa, 69.2% hi, 0.0% si This results in a very
> unresponsive system and a transfer rate of up to 1MB/s (my new
> camera writes with up to 10MB/s on the card...).

The drivers are working correctly; the problem is with the CF flash
adapter you're using.  There are two kinds of CF-to-PCMCIA adapters.
Some are 16-bit PCMCIA cards, which are in most cases limited to a bus
throughput of ~1 MB/sec, regardless of what the CF card is capable
of.  There are also 32-bit CF adapter cards, that are much faster,
limited only by the speed of the CF device.  Here are two:

http://www.delkin.com/delkin_products_adapters_cardbus.html
http://www.lexarmedia.com/readers/cf32bit.html

-- Dave
