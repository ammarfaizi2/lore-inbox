Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTKHCXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKHCXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:23:48 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:26599 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261463AbTKHCXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:23:46 -0500
Message-ID: <3FAC53AA.7070807@cyberone.com.au>
Date: Sat, 08 Nov 2003 13:23:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=/dev/hdd in 2.9.0-test9-mm2: lots (LOTS) of error
 messages
References: <20031106134314.GA3282@middle.of.nowhere> <200311070708.hA778Pe8008356@turing-police.cc.vt.edu>
In-Reply-To: <200311070708.hA778Pe8008356@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

>On Thu, 06 Nov 2003 14:43:14 +0100, Jurriaan <thunder7@xs4all.nl>  said:
>  
>
>>I tried to burn a CD using this command-line in 2.6.0-test9-mm2:
>>
>>sudo cdrecord -v dev="/dev/hdd" -dao -useinfo *.wav
>>
>>Result:
>>
>>[this about 5 times per second]
>>Nov  6 14:37:17 middle kernel: arq->state 4
>>Nov  6 14:37:17 middle kernel: Badness in as_put_request at drivers/block/as-
>>    
>>
>iosched.c:1783
>
>I'm seeing this as well burning an ISO in TAO mode on /dev/hdb, but slightly different traceback:
>
>Nov  6 16:03:06 turing-police kernel: arq->state 4
>Nov  6 16:03:07 turing-police kernel: Badness in as_put_request at drivers/block/as-iosched.c:1783
>Nov  6 16:03:07 turing-police kernel: Call Trace:
>Nov  6 16:03:07 turing-police kernel:  [as_put_request+113/140] as_put_request+0x71/0x8c
>Nov  6 16:03:07 turing-police kernel:  [elv_put_request+19/23] elv_put_request+0x13/0x17
>Nov  6 16:03:07 turing-police kernel:  [__blk_put_request+91/133] __blk_put_request+0x5b/0x85
>Nov  6 16:03:07 turing-police kernel:  [blk_put_request+35/67] blk_put_request+0x23/0x43
>Nov  6 16:03:07 turing-police kernel:  [sg_io+955/1072] sg_io+0x3bb/0x430
>Nov  6 16:03:07 turing-police kernel:  [scsi_cmd_ioctl+520/1204] scsi_cmd_ioctl+0x208/0x4b4
>Nov  6 16:03:07 turing-police kernel:  [avc_has_perm+57/67] avc_has_perm+0x39/0x43
>Nov  6 16:03:07 turing-police kernel:  [__copy_from_user_ll+76/90] __copy_from_user_ll+0x4c/0x5a
>Nov  6 16:03:07 turing-police kernel:  [cdrom_ioctl+29/3404] cdrom_ioctl+0x1d/0xd4c
>Nov  6 16:03:07 turing-police kernel:  [write_chan+432/451] write_chan+0x1b0/0x1c3
>Nov  6 16:03:07 turing-police kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
>Nov  6 16:03:07 turing-police kernel:  [selinux_file_permission+289/300] selinux_file_permission+0x121/0x12c
>Nov  6 16:03:07 turing-police kernel:  [idecd_ioctl+55/66] idecd_ioctl+0x37/0x42
>Nov  6 16:03:07 turing-police kernel:  [blkdev_ioctl+797/816] blkdev_ioctl+0x31d/0x330
>Nov  6 16:03:07 turing-police kernel:  [sys_ioctl+512/583] sys_ioctl+0x200/0x247
>Nov  6 16:03:07 turing-police kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>Nov  6 16:03:07 turing-police kernel:  [pfkey_xfrm_state2msg+686/2757] pfkey_xfrm_state2msg+0x2ae/0xac5
>
>(pfkey_xfrm_state2msg()??? But I'm not doing ipsec - is the traceback on crack? ;)
>  
>

Yes.

I have fixed this. It will be in the next mm.


