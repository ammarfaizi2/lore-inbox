Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTFDN5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTFDN5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:57:01 -0400
Received: from imsantv23.netvigator.com ([210.87.250.79]:43222 "EHLO
	imsantv23.netvigator.com") by vger.kernel.org with ESMTP
	id S263305AbTFDN46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:56:58 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       hugang <hugang@soulinfo.com>
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
Date: Wed, 4 Jun 2003 22:10:12 +0800
User-Agent: KMail/1.5.2
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030603211156.726366e7.hugang@soulinfo.com> <1054732481.20839.30.camel@gaston> <200306042151.10611.mflt1@micrologica.com.hk>
In-Reply-To: <200306042151.10611.mflt1@micrologica.com.hk>
X-OS: GNU/Linux+KDE
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306042210.12468.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 21:51, Michael Frank wrote:

Patch 2.5.70-mm3 and  compile with gcc295 OK

Bare multisuer with serial console,
no modules, network, usb, acpi .....

Is there any debug or progress output in this version
and how to use?

Regards
Michael

OK, made the history longer

Last login: Wed Jun  4 21:59:38 on tty2
[mhf@mhfl1 22:05:24 mhf]$ Stopping tasks: klogd entered refrigerator
=init entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=syslogd entered refrigerator
=open entered refrigerator
=open entered refrigerator
=open entered refrigerator
=open entered refrigerator
=open entered refrigerator
=login entered refrigerator
=login entered refrigerator
=login entered refrigerator
=login entered refrigerator
=login entered refrigerator
=login entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=open entered refrigerator
=comr entered refrigerator
=sleep entered refrigerator
=tst entered refrigerator
=tstr entered refrigerator
=|
Freeing memory: ..................|
Syncing disks before copy
Suspending devices
Suspending devices
hda: start_power_step(susp: 1, step: 0)
hda: start_power_step(susp: 1, step: 1)
hda: start_power_step(susp: 1, step: 2)
hda: complete_power_step(susp: 1, step: 2, stat: 50, err: 0)
hda: completing PM request, suspend: 1
Suspending devices
/critical section: Counting pages to copy[nosave c03f7000] (pages needed: 2273+512=2785 free: 14110)
Alloc pagedir
............ 
[nosave c03f7000]critical section/: done (2273 pages copied)
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(susp: 0, step: 0)
hda: start_power_step(susp: 0, step: 101)
hda: completing PM request, suspend: 0
Devices Resumed
Devices Resumed
Writing data to swap (2273 pages): .<3>bad: scheduling while atomic!
Call Trace:
 [<c011d958>] schedule+0x40/0x388
 [<c011eb02>] io_schedule+0xe/0x18
 [<c01384d5>] wait_on_page_bit_wq+0xc9/0xe4
 [<c011f320>] autoremove_wake_function+0x0/0x3c
 [<c011f320>] autoremove_wake_function+0x0/0x3c
 [<c01384fa>] wait_on_page_bit+0xa/0x10
 [<c014cc34>] rw_swap_page_sync+0x98/0xc6
 [<c0136afd>] write_suspend_image+0xf1/0x324
 [<c0246bdf>] device_resume+0x7f/0x88
 [<c01370e1>] drivers_unsuspend+0x11/0x18
 [<c013735e>] suspend_save_image+0x12/0x1c
 [<c013753f>] do_magic_suspend_2+0x17/0xa8
 [<c011ba9d>] do_magic+0x4d/0x130
 [<c013763b>] do_software_suspend+0x6b/0x90
 [<c0137695>] software_suspend+0x35/0x3c
 [<c012ba97>] sys_reboot+0x2df/0x36c
 [<c0143830>] unmap_page_range+0x38/0x5c
 [<c0143959>] unmap_vmas+0x105/0x208
 [<c01656e4>] dput+0x1c/0x204
 [<c01656e4>] dput+0x1c/0x204
 [<c015d367>] path_release+0xf/0x30
 [<c014fe69>] sys_chdir+0x5d/0x68
 [<c010af17>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011d958>] schedule+0x40/0x388
 [<c011eb02>] io_schedule+0xe/0x18
 [<c01384d5>] wait_on_page_bit_wq+0xc9/0xe4
 [<c011f320>] autoremove_wake_function+0x0/0x3c
 [<c011f320>] autoremove_wake_function+0x0/0x3c
 [<c01384fa>] wait_on_page_bit+0xa/0x10
 [<c014cc34>] rw_swap_page_sync+0x98/0xc6
 [<c0136afd>] write_suspend_image+0xf1/0x324
 [<c0246bdf>] device_resume+0x7f/0x88
 [<c01370e1>] drivers_unsuspend+0x11/0x18
 [<c013735e>] suspend_save_image+0x12/0x1c
 [<c013753f>] do_magic_suspend_2+0x17/0xa8
 [<c011ba9d>] do_magic+0x4d/0x130
 [<c013763b>] do_software_suspend+0x6b/0x90
 [<c0137695>] software_suspend+0x35/0x3c
 [<c012ba97>] sys_reboot+0x2df/0x36c
 [<c0143830>] unmap_page_range+0x38/0x5c
 [<c0143959>] unmap_vmas+0x105/0x208
 [<c01656e4>] dput+0x1c/0x204
 [<c01656e4>] dput+0x1c/0x204
 [<c015d367>] path_release+0xf/0x30
 [<c014fe69>] sys_chdir+0x5d/0x68
 [<c010af17>] syscall_call+0x7/0xb

-- 
Powered by linux-2.5.70-mm3
My current linux related activities in rough order of priority:
- Testing of 2.4/2.5 kernel interactivity
- Testing of Swsusp for 2.4
- Testing of Opera 7.11 emphasizing interactivity
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *

