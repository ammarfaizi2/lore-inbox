Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWH1Om4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWH1Om4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWH1Om4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:42:56 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:40666
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751026AbWH1Omz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:42:55 -0400
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk>
References: <20060828085244.GA13544@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 09:42:08 -0500
Message-Id: <1156776128.4528.3.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 09:52 +0100, Russell King wrote:
> asm/serial.h is supposed to contain the definitions for the architecture
> specific 8250 ports for the 8250 driver.  It may also define BASE_BAUD,
> but this is the base baud for the architecture specific ports _only_.
> 
> Therefore, nothing other than the 8250 driver should be including this
> header file.  In order to move towards this goal, here is a patch which
> removes some of the more obvious incorrect includes of the file.
> 
> MIPS and PPC has rather a lot of stuff in asm/serial.h, some of it looks
> related to non-8250 ports.  Hence, it's not trivial to conclude that
> these includes are indeed unnecessary, so can mips and ppc people please
> test this patch carefully.
...
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c

Acked-by: Paul Fulghum <paulkf@microgate.com>

-- 
Paul Fulghum
Microgate Systems, Ltd

