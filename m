Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbULZSGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbULZSGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULZSGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:06:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58776 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261717AbULZSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:06:02 -0500
Subject: Re: is my RAID safe?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: M Benz <mbenz74@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY15-F265CCA05303049813A8802B2980@phx.gbl>
References: <BAY15-F265CCA05303049813A8802B2980@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104080521.16049.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 17:02:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 14:30, M Benz wrote:
> Today I found this that at my /var/log/message (kernel 2.6.10):
> 
> Dec 26 21:35:14 s1 kernel: ata5: status=0x51 { DriveReady SeekComplete 
> Error }
> Dec 26 21:35:14 s1 kernel: ata5: error=0x84 { DriveStatusError BadCRC }
> 
> ata5 is md raid1 with ata6, both are sata drives connected to a promise 
> SATA controller.

BadCRC is usually cable noise. The kernel will retry such an event
several times, then fall back to PIO and try that before it gives up.

