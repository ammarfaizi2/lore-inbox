Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTDNTOA (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTDNTOA (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:14:00 -0400
Received: from web12108.mail.yahoo.com ([216.136.172.28]:22652 "HELO
	web12108.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263898AbTDNTN7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:13:59 -0400
Message-ID: <20030414192548.48370.qmail@web12108.mail.yahoo.com>
Date: Mon, 14 Apr 2003 12:25:48 -0700 (PDT)
From: Christian Staudenmayer <the_sithlord@yahoo.com>
Subject: kernel panic (2.5.67-ac1)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

(i've posted a similar message before but i've been told to add the whole error
message, so here it is. sorry about that, but typing screenfulls of hex numbers
makes me feel like a geek but it also makes my head hurt ;)

the 2.5.67 kernel boots fine here, but the -ac1 patch to it ends up in 
a kernel panic.
here are the last 25 lines of the error, i don't know if there is more above of it,
scrolling up didn't work... (btw there can be typos in it ;)

Process swapper (pid: 1, threadinfo=dbf8e000 task=dbf8c040)
Stack: c15259a8 c15259a8 00000001 00000002 dbf8fe48 c022cd1a c15259a8 000000ff
       dbf8fe3c dbf8fe40
Call Trace:
 [<c022cd1a>] ide_xlate_1024+0x106/0x18c
 [<c01654aa>] handle_ide_mess+0x14e/0x1e8
 [<c016557f>] msdos_partition+0x3b/0x3ec
 [<c01171fa>] release_console_sem+0x32/0x94
 [<c0117165>] printk+0xfd/0x114
 [<c016491d>] check_partition+0xa1/0xec
 [<c0164c13>] register_disk+0xa7/0x144
 [<c0164c28>] register_disk+0xbc/0x144
 [<c0218301>] add_disk+0x35/0x44
 [<c021829c>] exact_match+0x0/0xc
 [<c02182a8>] exact_lock+0x0/0x24
 [<c0273589>] sd_attach+0x1d/0x244
 [<c023d9c0>] scsi_register_device+0xb8/0xe4
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c01079c1>] kernel_thread_helper+0x5/0xc

Code: 8b 40 38 be 93 74 31 c0 ff d0 89 c1 c7 03 3f 00 00 00 85 ff
 <0>Kernel panic: Attempted to kill init!

The machine is a p3 700 with 448MB of ram, and it's running an old scsi 
disk at an adaptec 2940
controller that uses the aic7xxx drivers (at boot it says AIC7870).
When configuring (make menuconfig) the kernel, i loaded the saved 
config file that worked for 2.5.67.

Note: i am not subscribed to the lkml, perhaps i will later on, when 
i'm more experienced.
so, please email me at the_sithlord@yahoo.com
you can also drop by in my undernet channel called #hansapils

any help regarding this problem would be highly appreciated.

greetings, chris
the_sithlord@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
