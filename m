Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTJJFsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJJFsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:48:53 -0400
Received: from ns1.triode.net.au ([202.147.124.1]:41427 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP id S262440AbTJJFsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:48:50 -0400
Message-ID: <3F86480F.1080801@torque.net>
Date: Fri, 10 Oct 2003 15:47:59 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Chris Friesen <chris_friesen@sympatico.ca>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: unloading scsi debug module gives errors in logs
References: <3F860CF2.8010105@sympatico.ca>
In-Reply-To: <3F860CF2.8010105@sympatico.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> Seen on 2.6.0-test6:
> 
> Oct  9 21:22:25 doug kernel: SCSI device sda: 16384 512-byte hdwr 
> sectors (8 MB)
> Oct  9 21:22:25 doug kernel: SCSI device sda: drive cache: write back
> Oct  9 21:22:25 doug kernel:  sda: unknown partition table
> Oct  9 21:22:25 doug kernel: Attached scsi disk sda at scsi1, channel 0, 
> id 0, lun 0
> Oct  9 21:22:53 doug kernel: FAT: bogus number of reserved sectors
> Oct  9 21:22:53 doug kernel: VFS: Can't find a valid FAT filesystem on 
> dev sda.
> Oct  9 21:24:42 doug kernel: Device 'pseudo_0' does not have a release() 
> function, it is broken and must be fixed.
> Oct  9 21:24:42 doug kernel: Badness in device_release at 
> drivers/base/core.c:85
> Oct  9 21:24:42 doug kernel: Call Trace:
> Oct  9 21:24:42 doug kernel:  [device_release+68/80] 
> device_release+0x44/0x50
> Oct  9 21:24:42 doug kernel:  [kobject_cleanup+67/96] 
> kobject_cleanup+0x43/0x60
> Oct  9 21:24:42 doug kernel:  [kobject_put+20/32] kobject_put+0x14/0x20
> Oct  9 21:24:42 doug kernel:  [put_device+13/32] put_device+0xd/0x20
> Oct  9 21:24:42 doug kernel:  [device_unregister+17/32] 
> device_unregister+0x11/0x20
> Oct  9 21:24:42 doug kernel:  [__crc_generic_file_llseek+338540/1261671] 
> scsi_debug_exit+0x3b/0x4b [scsi_debug]
> Oct  9 21:24:42 doug kernel:  [sys_delete_module+301/336] 
> sys_delete_module+0x12d/0x150
> Oct  9 21:24:42 doug kernel:  [sys_munmap+55/96] sys_munmap+0x37/0x60
> Oct  9 21:24:42 doug kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Chris,
I have posted a patch to fix that on the linux-scsi list
titled: "[PATCH] scsi_debug lk 2.6.0t6". See:
http://marc.theaimsgroup.com/?l=linux-scsi&m=106561848728156&w=2

Doug Gilbert


