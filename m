Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbRGDMi0>; Wed, 4 Jul 2001 08:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRGDMiQ>; Wed, 4 Jul 2001 08:38:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264451AbRGDMiC>; Wed, 4 Jul 2001 08:38:02 -0400
Subject: Re: parport_pc tries to load parport_serial automatically
To: twaugh@redhat.com (Tim Waugh)
Date: Wed, 4 Jul 2001 13:38:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20010704133634.F5254@redhat.com> from "Tim Waugh" at Jul 04, 2001 01:36:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Hlv3-0000qs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#ifdef CONFIG_PARPORT_SERIAL_MODULE
> -	if (!ret)
> -		request_module ("parport_serial");
> -#endif
> -
>  	return ret;
>  }
>  
> --- linux/drivers/parport/ChangeLog.orig	Wed Jul  4 13:30:32 2001
> +++ linux/drivers/parport/ChangeLog	Wed Jul  4 13:32:01 2001
> @@ -0,0 +1,6 @@
> +2001-07-04  Tim Waugh  <twaugh@redhat.com>
> +
> +	* parport_pc.c (init_module): Don't try to load parport_serial.
> +	This means that the user needs to load it (or a hardware detection
> +	program on their behalf) if necessary.
> +

Can hotplug handle this from a PCI id table ?

