Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUAVViQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUAVViQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:38:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48391 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266397AbUAVViA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:38:00 -0500
Date: Thu, 22 Jan 2004 21:37:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arne Ahrend <aahrend@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-ID: <20040122213757.H23535@flint.arm.linux.org.uk>
Mail-Followup-To: Arne Ahrend <aahrend@web.de>,
	linux-kernel@vger.kernel.org
References: <20040122210501.40800ea7.aahrend@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040122210501.40800ea7.aahrend@web.de>; from aahrend@web.de on Thu, Jan 22, 2004 at 09:05:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:05:01PM +0100, Arne Ahrend wrote:
> There appears to be a problem with unplugging PCMCIA
> ethernet cards under 2.6. I have to run ifconfig .. down
> manually before removing the card from its socket,
> otherwise the system generates unkillable processes,
> reconnecting the card later does not work and the
> file systems cannot be unmounted properly.

It works for me - with pcnet_cs.  Do you have ipv6 configured into the
kernel?

Anyway, I'd be useful if you can reproduce the unkillable process, then
dump the task state (sysrq-t) and send the trace for the hung ifconfig
process.

> /sbin/ifdown reports eth0 as unconfigured, this is normal,
> it also happens under 2.4. The "Hw. address read/write mismap"
> messages indicate trouble under 2.6...

This merely means that the driver tried to access some register and
found that the hardware was already gone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
