Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTEOQSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTEOQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:18:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12040 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264097AbTEOQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:18:05 -0400
Date: Thu, 15 May 2003 17:30:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] IRQ and resource for platform_device
Message-ID: <20030515173052.C31491@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030515145920.B31491@flint.arm.linux.org.uk> <20030515090350.A7685@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030515090350.A7685@home.com>; from mporter@kernel.crashing.org on Thu, May 15, 2003 at 09:03:50AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 09:03:50AM -0700, Matt Porter wrote:
> On Thu, May 15, 2003 at 02:59:20PM +0100, Russell King wrote:
> > The location and interrupt of some platform devices are only known by
> > platform specific code.  In order to avoid putting platform specific
> > parameters into drivers, place resource and irq members into struct
> > platform_device.
> > 
> > Discussion point: is one resource and one irq enough?
> 
> No.
> 
> We have the same need for PPC SoC and system controller on-chip
> devices.  Some devices have multiple interrupts and/or resources.

Is there a sane limit on the number of interrupts and resources for one
device?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

