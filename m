Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbXAONK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXAONK1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXAONK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:10:27 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34303
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932310AbXAONK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:10:27 -0500
Message-Id: <45AB8BB1.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 15 Jan 2007 13:12:01 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Martin Bretschneider" <martin.bretschneider@imr.uni-hannover.de>
Cc: <mb@bu3sch.de>, <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: new HW RNG freezes kernels > 2.6.17 at startup with Xeon
	5130
References: <45AB6E8C.4090408@imr.uni-hannover.de>
In-Reply-To: <45AB6E8C.4090408@imr.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch was sent out to (hopefully) address this problem (or at least allow you to
work around it), which had been reported for a similar machine before. The patch
is present in 2.6.20-rc5.

Jan

>>> Martin Bretschneider <martin.bretschneider@imr.uni-hannover.de> 15.01.07 13:07 >>>
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
