Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUFGWwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUFGWwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFGWwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:52:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33546 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265097AbUFGWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:52:15 -0400
Subject: 2.6.7-rc3: waiting for eth0 to become free
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 08 Jun 2004 00:52:21 +0200
Message-Id: <1086648742.1740.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On my laptop, when using a CardBus 3c59x-based NIC, I need to run
"cardctl eject" so the system won't freeze when resuming. "cardctl
eject" worked fine in 2.6.7-rc2-mm2, even when there were programs with
network sockets opened (for example, Evolution mantaining a connection
against an IMAP server): the card is ejected (well, not physically),
even when there are ESTABLISHED connections.

However, starting with 2.6.7-rc3, "cardctl eject" hangs if a program
holds any socket open. After a while the "unregister_netdevice: waiting
for eth0 to become free" message starts appearing on the kernel message
ring. The only apparent solution is killing that program, ejecting the
card from its slot and wait until 3c59x.o usage count reaches zero.

Can someone tell me what's going on here?
Thank you very much.


