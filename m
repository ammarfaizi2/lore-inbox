Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUJPVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUJPVkX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268892AbUJPVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:40:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18871 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268890AbUJPVkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:40:22 -0400
Message-ID: <41719537.1080505@pobox.com>
Date: Sat, 16 Oct 2004 17:40:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
Subject: Hang on x86-64, 2.6.9-rc3-bk4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A reproducible, hard hang on x86-64, during bootup's fsck ("touch 
/forcefsck").  Athlon64, VIA motherboard, Promise SATA, VIA SATA, 512MB, 
r8169.  Hang begins in 2.6.9-rc3-bk4, everything works in 2.6.9-rc3-bk3. 
  Hang persists in 2.6.9-rc4 and 2.6.9-final.

Symptoms:  touch /forcefsck and reboot.  fsck will successfully check 
all partitions of the WD drive attached to Promise, then fail precisely 
54% through the fsck on the Maxtor drive attached to VIA SATA.  SysRq 
will print out the command header, but no output, for sysrq-[tps]. 
sysrq-m works...  for a little while.  then the machine completely 
hangs, no sysrq or anything.

This is 100% reproducible.

There are -no- SATA driver changes between -bk3 and -bk4 AFAICS, which 
leads me to guess at VM, or x86-64 platform?

The diff between -bk3 and -bk4 is pretty small, if you ignore the ARM 
and m32r arch changes.

	Jeff



