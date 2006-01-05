Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWAESqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWAESqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWAESqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:46:46 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:48579 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750868AbWAESqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:46:45 -0500
Date: Thu, 5 Jan 2006 11:46:45 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>,
       parisc <parisc-linux@parisc-linux.org>
Subject: Re: [parisc-linux] [CFT 10/29] Add parisc_bus_type probe and remove methods
Message-ID: <20060105184645.GX19769@parisc-linux.org>
References: <20060105142951.13.01@flint.arm.linux.org.uk> <20060105142951.13.10@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105142951.13.10@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 02:34:38PM +0000, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Works fine, Acked-by: Matthew Wilcox <matthew@wil.cx>

> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/parisc/kernel/drivers.c linux/arch/parisc/kernel/drivers.c
> --- linus/arch/parisc/kernel/drivers.c	Sun Nov  6 22:14:46 2005
> +++ linux/arch/parisc/kernel/drivers.c	Sun Nov 13 16:08:49 2005
> @@ -173,8 +173,6 @@ int register_parisc_driver(struct parisc
>  	WARN_ON(driver->drv.probe != NULL);
>  	WARN_ON(driver->drv.remove != NULL);

I wonder if you want to delete the two WARN_ONs here too.
