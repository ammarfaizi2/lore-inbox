Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVGaWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVGaWik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGaWgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:36:01 -0400
Received: from tim.rpsys.net ([194.106.48.114]:64420 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262022AbVGaWeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:34:03 -0400
Subject: Re: [patch] ucb1x00: touchscreen cleanups
From: Richard Purdie <rpurdie@rpsys.net>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050731221152.71074.qmail@web30303.mail.mud.yahoo.com>
References: <20050731221152.71074.qmail@web30303.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 23:33:28 +0100
Message-Id: <1122849209.7626.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 23:11 +0100, Mark Underwood wrote:
> As this isn't the only chip of this sort (i.e. a
> multi-function chip not on the CPU bus) maybe we
> should store the bus driver in a common place. If
> needed we could have a very simple bus driver
> subsystem (this might already be in the kernel, I
> haven't looked at the bus stuff) in which you register
> a bus driver and client drivers register with the bus
> driver. Just an idea :-).

This was the idea with the drivers/soc suggestion although I think that
name is perhaps misleading.

How about drivers/mfd where mfd = Multi Functional Devices?

I think it would be acceptable (and in keeping with the other drivers
e.g. pcmcia) to seeing the arch and platform specific modules with the
main driver as long as the naming reflected it (like the existing mcp
and ucb code does) i.e.:

mcp-core.c
mcp-sa1100.c
ucb1x00-code.c
ucb1x00-assabet.c
ucb1x00-collie.c

If code can be separated out into subsystems, I'm not so sure where they
should go though. The existing policy would suggest
drivers/input/touchscreen and sound/xxx for these...

ucb1x00-ts.c
ucb1x00-audio.c

Opinions/Comments?

Richard

