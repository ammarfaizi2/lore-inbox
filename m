Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVCWIjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVCWIjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVCWIjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:39:00 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:46487 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262859AbVCWIi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:38:59 -0500
Date: Wed, 23 Mar 2005 11:38:58 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Pawe__ Sikora <pluto@pld-linux.org>,
       linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][alpha] "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
Message-ID: <20050323113858.A4941@jurassic.park.msu.ru>
References: <200503152335.48995.pluto@pld-linux.org> <20050322130657.7502418d.akpm@osdl.org> <424093C8.400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <424093C8.400@pobox.com>; from jgarzik@pobox.com on Tue, Mar 22, 2005 at 04:53:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 04:53:12PM -0500, Jeff Garzik wrote:
> Although I suppose its possible that some alpha machines have SMI 
> hardware, I don't think I've ever seen ACPI or IPMI on any alpha.

Yes, this stuff doesn't exist. I think it would be correct to add
the following to drivers/char/ipmi/Kconfig, like it's done for ACPI:

menu "IPMI"
+	depends on IA64 || X86

config IPMI_HANDLER
       tristate 'IPMI top-level message handler'
+	depends on IA64 || X86


Ivan.
