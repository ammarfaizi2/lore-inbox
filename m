Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTEOSAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEOSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:00:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24841 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264134AbTEOSAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:00:49 -0400
Date: Thu, 15 May 2003 19:13:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] IRQ and resource for platform_device
Message-ID: <20030515191336.E31491@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030515145920.B31491@flint.arm.linux.org.uk> <20030515090350.A7685@home.com> <20030515173052.C31491@flint.arm.linux.org.uk> <20030515103513.B7685@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030515103513.B7685@home.com>; from mporter@kernel.crashing.org on Thu, May 15, 2003 at 10:35:13AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:35:13AM -0700, Matt Porter wrote:
> On Thu, May 15, 2003 at 05:30:52PM +0100, Russell King wrote:
> > Is there a sane limit on the number of interrupts and resources for one
> > device?
> 
> As of today, I know of a device that has 5 interrupts and another
> with 2 interrupts.  I believe two resources is the most I've seen
> so far on a "dumb" on-chip device.
> 
> I think having an array of irqs and resources of max count 8 should
> do it for now.
> 
> No matter what we choose, the hardware designers will screw it up
> eventually.

Hmm, how would people feel if I suggested just:

	int num_resources;
	struct resource	*resources;

We have an IORESOURCE_IRQ, which can be used to indicate IRQ
resources.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

