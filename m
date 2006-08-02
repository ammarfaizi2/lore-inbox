Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWHBOwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHBOwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHBOwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:52:11 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61150 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751037AbWHBOwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:52:10 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+serial@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] at91_serial: Introduction
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 02 Aug 2006 16:51:45 +0200
Message-Id: <11545303083273-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 patches make the at91_serial driver usable on AVR32.
The last two patches are not really AVR32-specific and may be
considered as general bug fixes.

There are a few bigger changes I want to do to the at91_serial driver.
If you have objections to any of this, please speak up.

The avr32-arch patch in -mm contains copies of a few files in
include/asm-arm/arch-at91, among others at91rm9200_usart.h. This
duplication is really unnecessary, and I suggest we move the file into
drivers/serial so that it can be used by all architectures.

Since at91_serial can be used by devices other than at91, it's really
a bit misnamed. I'd like to rename it to atmel_serial. Would you
accept a huge patch to do that?

There's also a different driver around for the same piece of hardware
that I wrote almost from scratch a couple of years ago, and that's
distributed with the AT32STK1000 BSP. I'm planning to phase out that
driver, but before I do I want to go through it and try to integrate
all the good stuff into the at91_driver.

Another thing: Andrew, are you the official maintainer of this driver?
If not, who is?

Haavard
