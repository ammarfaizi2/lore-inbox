Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTEOPvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTEOPvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:51:06 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:62613 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S264093AbTEOPvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:51:05 -0400
Date: Thu, 15 May 2003 09:03:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] IRQ and resource for platform_device
Message-ID: <20030515090350.A7685@home.com>
References: <20030515145920.B31491@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030515145920.B31491@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, May 15, 2003 at 02:59:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 02:59:20PM +0100, Russell King wrote:
> The location and interrupt of some platform devices are only known by
> platform specific code.  In order to avoid putting platform specific
> parameters into drivers, place resource and irq members into struct
> platform_device.
> 
> Discussion point: is one resource and one irq enough?

No.

We have the same need for PPC SoC and system controller on-chip
devices.  Some devices have multiple interrupts and/or resources.

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
