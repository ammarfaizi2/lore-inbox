Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRC3Xzl>; Fri, 30 Mar 2001 18:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbRC3Xzb>; Fri, 30 Mar 2001 18:55:31 -0500
Received: from unimur.um.es ([155.54.1.1]:20400 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S131733AbRC3XzW>;
	Fri, 30 Mar 2001 18:55:22 -0500
Date: Sat, 31 Mar 2001 01:59:39 +0200 (CEST)
From: Juan Piernas Canovas <piernas@ditec.um.es>
To: Tim Waugh <twaugh@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [SOLVED]Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
In-Reply-To: <20010330152921.Q10553@redhat.com>
Message-ID: <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Tim Waugh wrote:

> On Fri, Mar 30, 2001 at 03:55:01PM +0200, Juan Piernas Canovas wrote:
> 
> > The kernel configuration is the same in both 2.2.17 and 2.2.19.
> > Perhaps, the problem is not in the ppa module, but in the parport,
> > parport_pc or parport_probe modules.
> 
> There weren't any parport changes in 2.2.18->2.2.19, and the ones in
> 2.2.17->2.2.18 won't affect you unless you are using a PCI card.
> 
> Could you please try this patch and let me know if the behaviour
> changes?
> 
> Thanks,
> Tim.
> */
> 
> --- linux/drivers/scsi/ppa.h.eh	Fri Mar 30 15:27:43 2001
> +++ linux/drivers/scsi/ppa.h	Fri Mar 30 15:27:52 2001
> @@ -178,7 +178,6 @@
>  		eh_device_reset_handler:	NULL,			\
>  		eh_bus_reset_handler:		ppa_reset,		\
>  		eh_host_reset_handler:		ppa_reset,		\
> -		use_new_eh_code:		1,			\
>  		bios_param:			ppa_biosparam,		\
>  		this_id:			-1,			\
>  		sg_tablesize:			SG_ALL,			\
> 

Yes!!!. It works. I am happy now :-)

Thank you very much, Tim.

	Juan.

