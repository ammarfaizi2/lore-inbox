Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUHUI4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUHUI4i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUHUI4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:56:38 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:13786 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268914AbUHUI4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:56:36 -0400
Message-ID: <41270EB4.5030104@drzeus.cx>
Date: Sat, 21 Aug 2004 10:58:28 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Timer allocates too many ports
References: <4126600F.4050302@drzeus.cx>	<20040820140503.67d23479.rddunlap@osdl.org>	<41266C5D.7000908@drzeus.cx> <20040820144106.46fb3b1b.rddunlap@osdl.org>
In-Reply-To: <20040820144106.46fb3b1b.rddunlap@osdl.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Fri, 20 Aug 2004 23:25:49 +0200 Pierre Ossman wrote:
>
>
>| I do not know which file contains this allocation so I haven't been able 
>| to change it. Any ideas?
>
>Sure, arch/i386/kernel/setup.c, near line 221 (in 2.6.8.1):
>
>	.name	= "timer",
>	.start	= 0x0040,
>	.end	= 0x005f,
>	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
>
>Just split that into 2 entries in the standard_io_resources[] array
>and it's done.
>
>  
>
Thanks. That worked perfectly. Who is the responsible maintainer for 
this part of the kernel? When my driver is ready to be added to the 
Linus' kernel I need to have this changed.

Rgds
Pierre

