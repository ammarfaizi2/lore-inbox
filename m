Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbTIKAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266122AbTIKAX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:23:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:25730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266121AbTIKAXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:23:55 -0400
Date: Wed, 10 Sep 2003 17:24:05 -0700
From: Greg KH <greg@kroah.com>
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
Message-ID: <20030911002404.GA7178@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com> <20030910154608.14ad0ac8.akpm@osdl.org> <1063239544.1328.22.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063239544.1328.22.camel@ranjeet-pc2.zultys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 05:19:05PM -0700, Ranjeet Shetye wrote:
> 
> Your changes fixed the issue. Thanks a lot for your help. I still get
> this call trace, but no more OOPS on bootup.
> 
> kobject_register failed for Ensoniq AudioPCI (-17)
> Call Trace:
>  [<c026f45c>] kobject_register+0x50/0x59
>  [<c02f8003>] bus_add_driver+0x4c/0xaf
>  [<c02f8453>] driver_register+0x31/0x35
>  [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
>  [<c027c491>] pci_register_driver+0x5e/0x83
>  [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
>  [<c068475a>] do_initcalls+0x2a/0x97
>  [<c012e920>] init_workqueues+0x12/0x2a
>  [<c01050a3>] init+0x39/0x196
>  [<c010506a>] init+0x0/0x196
>  [<c0108f31>] kernel_thread_helper+0x5/0xb

Odds are that the pci driver is trying to register 2 drivers with the
pci core with the same name.  What does /sys/bus/pci/drivers show?

thanks,

greg k-h
