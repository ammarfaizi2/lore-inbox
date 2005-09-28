Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVI1Kq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVI1Kq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVI1Kq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:46:27 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:23511 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751212AbVI1Kq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:46:26 -0400
Message-ID: <433A747E.3070705@anagramm.de>
Date: Wed, 28 Sep 2005 12:46:22 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.2 crash on shutdown on SMP machine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Last night, right before thinking about going to bed, my newly
installed old SMP machine crashed after a #shutdown -h now
as shown below:

linux-2.6.13.2
old Tyan Tomcat Board, Dual Processor, 2xPentium MMX 200MHz
SMP enabled, preemption enabled..

[...]
Shutdown: hda
Power down.
Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
c010fdd5    send_IPI_mask_bitmask+0x65/0x70
c0110236    smp_send_reschedule+0x16/0x20
c01188d6    __migrate_task+0xb6/0xc0
c01189ad    migration_thread+0xcd/0x120
c01188e0    migration_thread+0x0/0x120
c012ef43    kthread+0x93/0xc0
c012eeb0    kthread+0x0/0x120
c010104d    kernel_thread_helper+0x5/0x18

The board cannot do any acpi and auto-powerdown thing.
It should just stop after "Power down."

I can try the latest git or 2.6.14-rc2 tonight and get you
some more info (.config) when I am back home...
BTW what is IPI? Any ideas? What do you need to track down
this issue?

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
