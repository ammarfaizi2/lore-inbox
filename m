Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUFXRCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUFXRCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFXRCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:02:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57610 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266198AbUFXRCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:02:42 -0400
Date: Thu, 24 Jun 2004 18:02:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dag Nygren <dag@newtech.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 Oops when removing PCMCIA memory card
Message-ID: <20040624180239.A29156@flint.arm.linux.org.uk>
Mail-Followup-To: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org
References: <20040624095205.29088.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040624095205.29088.qmail@dag.newtech.fi>; from dag@newtech.fi on Thu, Jun 24, 2004 at 12:52:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 12:52:05PM +0300, Dag Nygren wrote:
> just an into this Oops on my laptop during the following procedure:
> 
> - Inserted a PCMCIA adapter with a CompactFlash
> - This was recognized and mounted readonly as requested
> - A number of pictures was copied from it
> - The card was unmounted
> - Ejected the PCMCIA adapter and got the Oops

I'd be grateful if you could test 2.6.7-mm2.

> This seems to be repeatable as it happened again after a reboot.

Yes, it's a known problem caused by the way ide-cs fiddles with resources
owned by the PCMCIA layer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
