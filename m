Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbULQADv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbULQADv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbULQADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:03:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35815 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262203AbULQACu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:02:50 -0500
Subject: Re: [PATCH] moxa: Update status of Moxa Smartio driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: james4765@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20041212130113.10564.41012.78969@localhost.localdomain>
References: <20041212130113.10564.41012.78969@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103237818.21920.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 22:57:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-12 at 13:00, james4765@verizon.net wrote:
> After contacting Moxa, I found out that they no longer maintain the in-kernel
> driver, and instead maintain an updated driver as an external patch.

> +http://www.moxa.com
> +
> +that works with 2.6 kernels.  Currently, Moxa has no plans to have their updated
> +driver merged into the kernel.

Works with 2.6 kernels up to 2.6.8 and providing its a 32bit machine and
you don't use some try and send a break.

Actually if you filter all the 2.2/2.4 ifdefs out of it and clean up the
formatting a bit its not a badly written driver and its GPL. I've
forward ported/fixed a cleaned up 2.6.9 version and dropped it into -ac
(on the grounds the existing one doesn't work at all so this is
progress).

Someone with some PCI moxa cards as opposed to ISA needs to add hotplug
support to it so that it uses pci_register foo rather than scanning the
bus old style.

Once we have something stable I can test with I'll tweak it for the
2.6.10 changes and submit it to the main tree.

Alan

