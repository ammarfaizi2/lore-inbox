Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbULGMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbULGMJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbULGMJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 07:09:39 -0500
Received: from mail.timesys.com ([65.117.135.102]:28992 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261793AbULGMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 07:09:38 -0500
Subject: Re: Second Attempt: Driver model usage on embedded processors
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Dec 2004 07:09:37 -0500
Message-Id: <1102421377.6162.8.camel@jmcmullan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 23:03 -0600, Kumar Gala wrote:
> The intent was that I would use the platform_data pointer to pass board 
> specific information to the driver.  We would have board specific code 
> which would fill in the information.  The question I have is how to 
> handle the device variant information which is really static?

I use a 'struct device_ethernet_data' in my MPC85xx platform-device
patches at http://www.evillabs.net/~gus/patches

That seems to work well, and we could move it from
include/asm-ppc/device-ethernet.h to include/linux/device-ethernet.h to
make it more arch-independant. That covers MAC addrs and phy locations.

As for PHY IRQ, that's a thornier issue. For now, I put that in the
ethernet device's resource list.

-- 
Jason McMullan <jason.mcmullan@timesys.com>
