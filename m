Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbUBLWei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUBLWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:34:38 -0500
Received: from motgate8.mot.com ([129.188.136.8]:31426 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S266665AbUBLWec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:34:32 -0500
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
	unless indicated otherwise in the message.
From: "Gopi Palaniappan" <gpalani1@urbana.css.mot.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: memory foorprint of kernel modules
Date: Thu, 12 Feb 2004 16:34:25 -0600
Message-ID: <BDEMIINGEPCMIFLFPKCKIEFFCCAA.gpalani1@urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.53.0402121543070.28272@chaos>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard:
    I am not sure looking at the ksyms will give me an actual measure.
Lets take an example,
I have a driver "foo.o" that i insmod, lets say. If this driver uses kmalloc
or malloc to dynamically
utilize RAM space for its internal operation, I don't think your suggested
method will capture
that dynamic allocation of memory, am i correct?

  I want to get a real-time ram usage of a specified dynamically loaded
module.

thanks,
Gopi



On Thu, 12 Feb 2004, Gopi Palaniappan wrote:

> Is there an easy way to measure the memory/RAM footprint of dynamically
> loaded kernel modules?
> Are there tools similar to "pmap" for this purpose?
>
>

You might make some sense of /proc/ksyms...

This is for a module called ramdisk.

Script started on Thu Feb 12 15:41:10 2004
cd /proc
# strings ksyms | grep ramdisk
[ramdisk]
[ramdisk]
d4a19510 __insmod_ramdisk_S.bss_L4
[ramdisk]
d4a19100 __insmod_ramdisk_S.rodata_L563
d4a18000
__insmod_ramdisk_O/root/Message-Based/drivers/target/ramdisk.o_M4027E0AD_V13
2120
d4a18054 __insmod_ramdisk_S.text_L4237
d4a19398 __insmod_ramdisk_S.data_L5
[ramdisk]
# exit

