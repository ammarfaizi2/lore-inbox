Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFDNpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTFDNpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:45:32 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:40426 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263298AbTFDNpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:45:31 -0400
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: hugang <hugang@soulinfo.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306042151.10611.mflt1@micrologica.com.hk>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	 <1054659866.20839.10.camel@gaston> <1054732481.20839.30.camel@gaston>
	 <200306042151.10611.mflt1@micrologica.com.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054735117.21552.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Jun 2003 15:58:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 15:51, Michael Frank wrote:
> Patch 2.5.70-mm3 and  compile with gcc295 OK
> 
> Bare multisuer with serial console, 
> no modules, network, usb, acpi .....
> 
> During suspend, after a while (some dots on the console)  
> got the output below in an endless loop
> 
> Is there any debug or progress output in this version
> and how to use?

I'm not sure how to interpret that call trace, was there any
other message just before ? There is some debug output in the
patch though it may have been lost at that point.

Ben.

> Regards
> Michael
> 
> Call Trace:
>  [<c011d958>] schedule+0x40/0x388
>  [<c011eb02>] io_schedule+0xe/0x18
>  [<c01384d5>] wait_on_page_bit_wq+0xc9/0xe4
>  [<c011f320>] autoremove_wake_function+0x0/0x3c
>  [<c011f320>] autoremove_wake_function+0x0/0x3c
>  [<c01384fa>] wait_on_page_bit+0xa/0x10
>  [<c014cc34>] rw_swap_page_sync+0x98/0xc6
>  [<c0136afd>] write_suspend_image+0xf1/0x324
>  [<c0246bdf>] device_resume+0x7f/0x88
>  [<c01370e1>] drivers_unsuspend+0x11/0x18
>  [<c013735e>] suspend_save_image+0x12/0x1c
>  [<c013753f>] do_magic_suspend_2+0x17/0xa8
>  [<c011ba9d>] do_magic+0x4d/0x130
>  [<c013763b>] do_software_suspend+0x6b/0x90
>  [<c0137695>] software_suspend+0x35/0x3c
>  [<c012ba97>] sys_reboot+0x2df/0x36c
>  [<c0143830>] unmap_page_range+0x38/0x5c
>  [<c0143959>] unmap_vmas+0x105/0x208
>  [<c01656e4>] dput+0x1c/0x204
>  [<c01656e4>] dput+0x1c/0x204
>  [<c015d367>] path_release+0xf/0x30
>  [<c014fe69>] sys_chdir+0x5d/0x68
>  [<c010af17>] syscall_call+0x7/0xb
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
