Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUFGXKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUFGXKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUFGXKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:10:18 -0400
Received: from karnickel.franken.de ([193.141.110.11]:26129 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S265118AbUFGXKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:10:13 -0400
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
From: Erik Tews <erik@debian.franken.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1086648742.1740.1.camel@teapot.felipe-alfaro.com>
References: <1086648742.1740.1.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1086649443.21227.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 01:04:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 08.06.2004 schrieb Felipe Alfaro Solana um 0:52:
> On my laptop, when using a CardBus 3c59x-based NIC, I need to run
> "cardctl eject" so the system won't freeze when resuming. "cardctl
> eject" worked fine in 2.6.7-rc2-mm2, even when there were programs with
> network sockets opened (for example, Evolution mantaining a connection
> against an IMAP server): the card is ejected (well, not physically),
> even when there are ESTABLISHED connections.
> 
> However, starting with 2.6.7-rc3, "cardctl eject" hangs if a program
> holds any socket open. After a while the "unregister_netdevice: waiting
> for eth0 to become free" message starts appearing on the kernel message
> ring. The only apparent solution is killing that program, ejecting the
> card from its slot and wait until 3c59x.o usage count reaches zero.

I have seen similar problems with my prism2 minipci-card. I often unload
the driver to reset the card, sometimes it hangs during unloading with
the same message. Would it be possible to add some code to backtrace
this lock?

This happens with a lot of recent 2.6 kernels, not always reproduceable.

