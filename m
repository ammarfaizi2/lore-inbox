Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJWXkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJWXkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:40:19 -0400
Received: from smtp2.home.se ([213.214.194.102]:56661 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id S261892AbTJWXkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:40:16 -0400
Subject: r8169 bug in 2.4.22, too much work at interrupt indefinitely
From: "John B=?ISO-8859-1?Q?=E4ckstrand" ?= <sandos@home.se>
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Oct 2003 01:38:14 +0200
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1066952294.616b72c0sandos@home.se>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The r8169 driver in 2.4.22 with or without debian patches/acpi/usb devices sharing the same interrupt: the driver always ends up locking the machine by having indefinitely much to do in the interrupt handler? 

Commented the printk out, still hangs the machine anyway. It happens even without a cable in the card. I have found no references to any bug reports at all with this card, and I cant see any bugfixes being in 2.5/2.6 but not 2.4 either. I can see the card TX/RX:ing a few hundred packets or more (3-60 secs) before hanging.

Any way to debug this, or should I just try 2.6?

---
John Bäckstrand


