Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUB0O5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUB0O5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:57:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10882 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262894AbUB0O5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:57:33 -0500
Date: Fri, 27 Feb 2004 09:59:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       linux-scsi-owner@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <008801c3fd40$933d2ca0$6501a8c0@office>
Message-ID: <Pine.LNX.4.53.0402270955240.7189@chaos>
References: <008801c3fd40$933d2ca0$6501a8c0@office>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Brad Cramer wrote:

> OK, it took me some time, but here is what I did.
> I installed a debian kernel image (kernel_image-2.4.24-1-k7) to tell if this
> was just a problem with the driver or because of the upgrade to kernel 2.6.x
> I the sym53c8xx and sym53c8xx_2 drivers are modules and this is what I got.
>
> bigdaddy:~# modprobe sym53c8xx
> PCI: Found IRQ 11 for device 00:0f.0
> PCI: Sharing IRQ 11 with 00:0d.0
> PCI: Sharing IRQ 11 with 00:0d.1
[SNIPPED...everything was fine]

>
> and everything works fine, then when I do :
>

Did you `rmmod` the previos driver???  If not, you have
two drivers pounding on the same board, attempting to
handle the same disk(s). All bets are off.

> bigdaddy:~# modprobe sym53c8xx_2
[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


