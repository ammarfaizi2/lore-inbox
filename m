Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266423AbUGPO3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbUGPO3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUGPO3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:29:45 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:50444 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S266423AbUGPO3n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:29:43 -0400
Date: Fri, 16 Jul 2004 16:27:12 +0200 (CEST)
To: gene.heskett@verizon.net
Subject: Re: momentary sensors failure in gkrellm2
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <RmzLkwpu.1089988031.9917620.khali@gcu.info>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gene,

> I noticed tonight, while booted to 2.6.8-rc1, that my gkrellm display 
> was a little short, all the temps and voltages were on the missing 
> list.  So, based on the more eyeballs theory, I rebooted a few times 
> testing recent kernels.
> 
> Backing up to 2.6.7-mm6, it all worked, so I grabbed Andrews rc1-mm1 
> patch and installed that.
> 
> I'm happy to note that the sensors stuff is back among the living and 
> being displayed properly with 2.6.8-rc1-mm1.
> 
> I've no idea which of the patches involving the i2c stuff wasn't right 
> for my chipset (via686 & winbond 697hf IIRC), but something broke it 
> just for 2.6.8-rc1.

That's odd since there isn't much difference, if any, between the i2c
subsystems of all three kernel versions.

You could try 2.6.8-rc1-bk4 (or any later bk) which has had a significant
i2c subsystem update.

If you are able to reproduce the problem (presumably with your 2.6.8-rc1
kernel), hints about where the problem lies would help. Can you see the
sysfs files for your monitoring chip under /sys/bus/i2c/devices? Are
there any relevant error messages in the logs? I cannot help much from
just "it didn't work", as you must realize.

Both the via686 and the Winbond 697hf are ISA chips, not really I2C
(although they share the same subsystem) so it is possible that the
problem was caused by a conflict with, say, ACPI or PNP, which could
have reserved resources (namely I/O addresses) needed by the hardware
monitoring chip(s).

As a side note, I'd be quite surprised that you have both chips on the
same motherboard.

Hope that helps,
--
Jean "Khali" Delvare
