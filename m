Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbTLHQCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbTLHQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:02:05 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:11713 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S265438AbTLHQAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:00:30 -0500
Date: Mon, 8 Dec 2003 10:58:26 -0500
Message-Id: <200312081558.hB8FwQ7n027927@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-12-08, Per Buer <perbu () linpro ! no> wrote:

> I have an Supermicro Superserver (wow!) 8040 or 8060 with a two Intel
> Xeon (p3-based with 1MB cache) and a Mylex AcceleRAID 352. We recently
> upgraded from 2 to 4GB of memory.

> There seems to a problem with IO and high memory. Suddenly IO
> performance will degrade dramatically (throughput of about 50KB/s).
> Booting the machine with "mem=2048" remedies this.

> We have tried replacing the memory with another make - no luck.

You don't mention the kernel version--I'm guessing a 2.4.x?

This doesn't necessarily help you, but: I haven't seen that on a dual P3
with 3GB of RAM (configured with CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y and
CONFIG_HIGHIO=y) and an AcceleRAID 352, in 2.4.22.  (I did get oopses with
this card and 3GB in 2.2 kernel days, using the old bigmem patches for 2.2.
I didn't stick around to find out whose fault it was though, just dropped
back to 2GB)

So, try verifying you've got CONFIG_HIGHIO=y, and out of curiosity you
could try mem=3072, but if that doesn't help I'd suspect the motherboard. 
This box is... um... an Intel serverworks board whose exact model number
escapes me at the moment.

--
Hank Leininger <hlein@progressive-comp.com> 
  
