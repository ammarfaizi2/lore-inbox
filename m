Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbUJ1GPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUJ1GPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUJ1GNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:13:44 -0400
Received: from fmr99.intel.com ([192.55.52.32]:21220 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262833AbUJ1GMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:12:02 -0400
Subject: Re: [PATCH 5/5]8250_pnp fix
From: Len Brown <len.brown@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <1098327571.6132.228.camel@sli10-desk.sh.intel.com>
References: <1098327571.6132.228.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098943907.5399.0.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Oct 2004 02:11:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2004-10-20 at 23:00, Li Shaohua wrote:
> Hi,
> This is a small fix found when debugging the 8250 driver in IA64.
> 
> Thanks,
> Shaohua
> 
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> 
> --- 2.6/drivers/serial/8250_pnp.c.stg4  2004-09-28 11:27:42.371840736
> +0800
> +++ 2.6/drivers/serial/8250_pnp.c       2004-09-28 11:28:14.036027048
> +0800
> @@ -407,7 +407,7 @@ serial_pnp_probe(struct pnp_dev * dev, c
>         serial_req.irq = pnp_irq(dev,0);
>         serial_req.port = pnp_port_start(dev, 0);
>         if (HIGH_BITS_OFFSET)
> -               serial_req.port = pnp_port_start(dev, 0) >>
> HIGH_BITS_OFFSET;
> +               serial_req.port_high = pnp_port_start(dev, 0) >>
> HIGH_BITS_OFFSET;
>  #ifdef SERIAL_DEBUG_PNP
>         printk("Setup PNP port: port %x, irq %d, type %d\n",
>                serial_req.port, serial_req.irq, serial_req.io_type);
> 
> 
> 

