Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbULZSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbULZSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULZSK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:10:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60056 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261719AbULZSIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:08:43 -0500
Subject: Re: kernel 2.6.10: promise sx6000 not detected by i2o_block
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krause.J@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412252244.48875.Krause.J@gmx.de>
References: <200412252244.48875.Krause.J@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104080689.15994.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 17:04:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-25 at 21:44, Juergen Krause wrote:
> 0000:00:0c.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02)
> 0000:00:0c.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02)

The I2O layer expects the controller to be in I2O mode. You might want
to try adding the PCI identifier directly to drivers/message/i2o/pci.c
next to the DPT one.

