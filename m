Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVCUWfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVCUWfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCUWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:33:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:11717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262097AbVCUW20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:28:26 -0500
Date: Mon, 21 Mar 2005 14:28:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marko Rebrina <mrebrina@gmail.com>
Cc: linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>
Subject: Re: Problem with w6692 & kernel >=2.6.10
Message-Id: <20050321142823.672f0749.akpm@osdl.org>
In-Reply-To: <dd02451d050303132662482b66@mail.gmail.com>
References: <dd02451d050303132662482b66@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Rebrina <mrebrina@gmail.com> wrote:
>
> I have problem with w6692 (mISDN-2005-02-25) & kernel >=2.6.10 (with
> 2.6.9 is OK!) 

There haven't been any changes in the w6692 driver for ages, so I'd be
suspecting PCI changes or something like that.  Are you able to test
2.6.12-rc1?


> # lspci
> 0000:01:07.0 Network controller: Winbond Electronics Corp W6692 (rev 01)
> 
> # modprobe w6692pci  protocol=2
> FATAL: Error inserting w6692pci
> (/lib/modules/2.6.11/kernel/drivers/isdn/hardware/mISDN/w6692pci.ko):
> No such device
> 
> log:
> 
> CAPI Subsystem Rev 1.1.2.8
> capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
> Modular ISDN Stack core $Revision: 1.23 $
> mISDNd: kernel daemon started
> ISDN L1 driver version 1.11
> ISDN L2 driver version 1.19
> mISDN: DSS1 Rev. 1.26
> Capi 2.0 driver file version 1.14
> ISAC module $Revision: 1.16 $
> 
> Winbond W6692 PCI driver Rev. 1.12
> ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
> mISDN_w6692: found adapter Winbond W6692 at 0000:01:07.0
> W6692: Winbond W6692 version (0): W6692 V00
> kcapi: Controller 1: mISDN1 attached
> mISDNd: test event done
> w6692: IRQ 19 count 4
> kcapi: card 1 "mISDN1" ready.
> w6692 1 cards installed
> try_ok(13) try_wait(0) try_mult(0) try_inirq(0)
> irq_ok(4) irq_fail(0)
> release_l1 id 1
> release_udss1 refcnt 1 l3(f39faa40) inst(f39faab8)
> kcapi: card 1 down.
> kcapi: Controller 1: mISDN1 unregistered
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
