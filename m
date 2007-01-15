Return-Path: <linux-kernel-owner+w=401wt.eu-S932272AbXAOMOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXAOMOZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbXAOMOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:14:25 -0500
Received: from mira.imr.uni-hannover.de ([130.75.27.99]:49231 "HELO
	mira.imr.uni-hannover.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932272AbXAOMOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:14:24 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 07:14:23 EST
Message-ID: <45AB6E8C.4090408@imr.uni-hannover.de>
Date: Mon, 15 Jan 2007 13:07:40 +0100
From: Martin Bretschneider <martin.bretschneider@imr.uni-hannover.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, jbeulich@novell.com,
       mb@bu3sch.de
Subject: new HW RNG freezes kernels > 2.6.17 at startup with Xeon 5130
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems to me that the new hardware random number generator (HW RNG) 
freezes my hardware:

The CPU is Intel Xeon 5130 (Intel Core microarchitecture) [1] installed 
on Intel Server Board S5000VSA.

Linux is run in 64bit mode and the distribution is Debian Etch (but that 
should not matter).

If I take Debian's kernel 2.6.17 it boots :-)
If I take vanilla  kernel 2.6.17.9 it boots :-)
If I take Debian's kernel 2.6.18 it does not boot.
If I take vanilla  kernel 2.6.18.6 it does not boot.
If I take vanilla  kernel 2.6.19.1 it does not boot.
If I take vanilla  kernel 2.6.20-rc4 it does not boot.

There was no error thus it was not that easy to find out the problem. 
Comparing the boot logs of 2.6.17 and 2.6.18 the freeze ocurred before 
initializing the hardware random number generator. Thus I recompiled the 
vanilla Kernel 2.6.18.6 without support of the new HW RNG and it boots. 
So, I renamed the directory /kernel/drivers/char/hw_random and the 
Debian kernel 2.6.18 does also boot.

I have not testet the kernel > 2.6.18 but I guess that they will also 
boot without the new NW RNG.

Do you know the problem? Can I provide you more information?

TIA  Martin

[1]http://en.wikipedia.org/wiki/List_of_Intel_Xeon_microprocessors#Woodcrest
