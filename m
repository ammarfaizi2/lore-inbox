Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWJ3LBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWJ3LBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJ3LBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:01:24 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:19209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161246AbWJ3LBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:01:23 -0500
Date: Mon, 30 Oct 2006 11:01:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc[123]: Oops in __wake_up_common during htc magician resume.
Message-ID: <20061030110111.GA27373@flint.arm.linux.org.uk>
Mail-Followup-To: pHilipp Zabel <philipp.zabel@gmail.com>,
	linux-kernel@vger.kernel.org
References: <74d0deb30610250346u1f444a5brbc2c32b4ab83d3e2@mail.gmail.com> <74d0deb30610291413r5b651d17o12d3ccce3b212ee8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d0deb30610291413r5b651d17o12d3ccce3b212ee8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 11:13:53PM +0100, pHilipp Zabel wrote:
> On 10/25/06, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> >When I switched from 2.6.18 to 2.6.19-rc1 processes started to get killed
> >during resume due to an oops in __wake_up_common on my arm
> >pxa272 device (htc magician). The patches I used are at
> >http://userpage.fu-berlin.de/~zabel/magician/magician-patches-2.6.19-rc3-20061025.tar.bz2
> 
> The issue was that I had a device_driver on the platform bus.
> In a git bisect this error somehow didn't show up until
> [386415d88b1ae50304f9c61aa3e0db082fa90428] PM: platform_bus and
> late_suspend/early_resume
> After turning the offending device_driver into a platform_driver,
> everything works as expected.

I recently fixed a similar bug in the PXA2xx PCMCIA code, though it
had different symptoms.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
