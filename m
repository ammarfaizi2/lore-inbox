Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTGWQOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270430AbTGWQOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:14:11 -0400
Received: from [64.65.189.210] ([64.65.189.210]:9360 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S270416AbTGWQOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:14:08 -0400
Subject: Re: Dependency problem in 2.6.0-test1
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Amol Lad <amol@amplewave.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1058958553.32116.24.camel@amol.amplewave.com>
References: <1058958553.32116.24.camel@amol.amplewave.com>
Content-Type: text/plain
Message-Id: <1058977750.11797.0.camel@bubbles.imr-net.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 09:29:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 04:09, Amol Lad wrote:
> Hi,
> make && make install && make modules && make modules_install,
> 
> I get following error message
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.6.0-test1/kernel/drivers/char/agp/intel-agp.ko
> depmod:         agp_remove_bridge
> depmod:         agp_generic_free_gatt_table
> depmod:         agp_generic_enable
> ...
> ...
> ...
> 
> 
> but the symbols are already defined, 
> 
> [root@amol agp]# pwd
> /lib/modules/2.6.0-test1/kernel/drivers/char/agp
> [root@amol agp]# nm agpgart.ko | grep agp_remove_bridge
> 00000450 T agp_remove_bridge
> 00000062 r __kstrtab_agp_remove_bridge
> 00000008 r __ksymtab_agp_remove_bridge
> [root@amol agp]# 
> 
> My modules.dep in /lib/modules/2.6.0-test1 looks like
> .....
>  /lib/modules/2.6.0-test1/kernel/drivers/char/agp/agpgart.ko:
> 
>  /lib/modules/2.6.0-test1/kernel/drivers/char/agp/intel-agp.ko:
> 
>  /lib/modules/2.6.0-test1/kernel/drivers/char/agp/sworks-agp.ko:
> .....
> 
> I think here intel-agp is dependent on agpgart but this dependency is
> not in modules.dep.
> 
> please CC me
> 
> Thanks
> Amol
> 

Do you have the updated modutils package installed?


