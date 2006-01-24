Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWAXWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWAXWfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAXWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:35:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:20684
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750791AbWAXWfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:35:37 -0500
Date: Tue, 24 Jan 2006 14:35:27 -0800
From: Greg KH <greg@kroah.com>
To: Vasil Kolev <vasil@ludost.net>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Message-ID: <20060124223527.GA26337@kroah.com>
References: <1138093728.5828.8.camel@lyra.home.ludost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138093728.5828.8.camel@lyra.home.ludost.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> Hello,
> I have a machine that's currently running 2.4.28 with the promise_old
> driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> the following error occured, and no drives were detected/made available:
> 
>  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
>  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
>  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
>  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
>  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
>  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0x7d/0x84
>  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_driver+0x13/0x35
>  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 [pdc202xx_old]
>  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
>  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb

This means that some other driver tried to register with the same exact
name for the same bus.  As it looks like this is the ide bus, I suggest
asking on the linux ide mailing list.

thanks,

greg k-h
