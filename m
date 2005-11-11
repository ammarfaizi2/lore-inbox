Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKKFuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKKFuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 00:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKKFuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 00:50:04 -0500
Received: from tornado.reub.net ([202.89.145.182]:56209 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750708AbVKKFuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 00:50:02 -0500
Message-ID: <43743105.7030201@reub.net>
Date: Fri, 11 Nov 2005 18:49:57 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/2005 5:35 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> 
> - reiser4 seems to be broken when built as a module (due, I assume, to a
>   reiser4-specific kbuild change).  CONFIG_REISER4_FS=y will be needed.
> 
> - New git tree git-cfq.patch - CFQ I/O scheduler updates from Jens
> 
> - The git-pcmcia tree has been reinstated
> 
> - git-audit and the several -mm fixups to it have been dropped for now - it's
>   undergoing a bit of churn.
> 
> - Numerous subsystem updates.  Notably more v4l work.

Network is a no-go for me:

[root@tornado ~]# /etc/init.d/network restart
e100: 0000:06:03.0: e100_eeprom_load: EEPROM corrupted
e100: probe of 0000:06:03.0 failed with error -11
sky2 0000:04:00.0: unsupported chip type 0xff
sky2: probe of 0000:04:00.0 failed with error -95

Both drivers worked under 2.6.14-rc5-mm1, but failed with 2.6.14-mm2.  I also 
re-tested against 2.6.14-mm1 and this problem also occurs there (I didn't get 
to test this this far with -mm1, had too many problems with other things and 
been having other hassles such as dsl connection).

Somehow I doubt that these two cards are both genuinely faulty..........I can 
swap out with another e100 if need be.

New config is up at http://www.reub.net/kernel/

Otherwise compiles, starts up and shuts down fine.

Reuben

