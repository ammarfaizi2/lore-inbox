Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUCPJaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbUCPJaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:30:35 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:44462 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S263736AbUCPJ3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:29:12 -0500
Date: Tue, 16 Mar 2004 14:32:47 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.4-bk3 and usb key: OOPS at removal
Message-ID: <20040316090247.GB2048@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040315225031.224ccbaa@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315225031.224ccbaa@jack.colino.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a fix by James Bottomley in 2.6.4-bk4, which might fix your problem.
http://marc.theaimsgroup.com/?l=bk-commits-head&m=107928795812635&w=2

Please try the latest kernel.

Thanks
Maneesh

On Mon, Mar 15, 2004 at 09:57:19PM +0000, Colin Leroy wrote:
> Hi,
> 
> Using 2.6.4-bk3 (the patch found at kernel.org), on an iBook G4 (ohci/ehci), i get oopses when disconnecting an usb key:
> 
> P: C008C130 LR: C008D32C SP: C0D9FD70 REGS: c0d9fcc0 TRAP: 0301    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000008, DSISR: 40000000
> TASK = c0c46000[5] 'khubd' Last syscall: 120
> GPR00: C008D32C C0D9FD70 C0C46000 00000000 C0249294 E748F1C0 C0334350 C0350000
> GPR08: 0000000C C02BB82C C02B7580 E6E32650 42008028
> Call trace:
>  [c008d32c] sysfs_remove_link+0x14/0x24
>  [c010a4e0] class_device_dev_unlink+0x38/0x3c
>  [c010aa00] class_device_del+0xd0/0x12c
>  [c010aa74] class_device_unregister+0x18/0x34
>  [c015c2e4] scsi_remove_device+0x54/0xb0
>  [c015b70c] scsi_forget_host+0x40/0x7c
>  [c0154c70] scsi_remove_host+0x2c/0x6c
>  [ea3b9614] storage_disconnect+0x50/0x6c [usb_storage]
>  [c0198adc] usb_unbind_interface+0x88/0x8c
>  [c0109a40] device_release_driver+0x84/0x88
>  [c0109be0] bus_remove_device+0x74/0xd0
>  [c01085a8] device_del+0xac/0x104
>  [c019f538] usb_disable_device+0x9c/0xd8
>  [c01997a8] usb_disconnect+0x9c/0x134
>  [c019bbbc] hub_port_connect_change+0x28c/0x290
> 
> hth,
> -- 
> Colin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
