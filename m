Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSHLPxx>; Mon, 12 Aug 2002 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSHLPxx>; Mon, 12 Aug 2002 11:53:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26905 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318734AbSHLPxw>; Mon, 12 Aug 2002 11:53:52 -0400
Date: Mon, 12 Aug 2002 11:57:10 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200208121557.g7CFvAv10061@devserv.devel.redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.31
In-Reply-To: <mailman.1029062221.5995.linux-kernel2news@redhat.com>
References: <200208100551.46142.ivangurdiev@attbi.com.suse.lists.linux.kernel> <p73r8h5itu7.fsf@oldwotan.suse.de> <mailman.1029062221.5995.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > drivers/built-in.o: In function `parport_pc_probe_port':
>> > drivers/built-in.o(.text+0x2dbf6): undefined reference to `request_dma'
>> > drivers/built-in.o(.text+0x2dc98): undefined reference to `free_dma'
>> > drivers/built-in.o: In function `parport_pc_unregister_port':
>> > drivers/built-in.o(.text+0x2df94): undefined reference to `free_dma'
>> > drivers/built-in.o(.data+0x4c20): undefined reference to `request_dma'
>> > drivers/built-in.o(.data+0x4c24): undefined reference to `free_dma'
>> > make: *** [vmlinux] Error 1
>> 
>> make oldconfig and recompiling should fix that.
> 
> Hmm, is it time to make .config depend on arch/$(ARCH)/config.in and all
> Config.in files?
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux

Just make sure that the rule is
"\t@echo "Dumbass, you forgot to run make oldconfig",
instead of just running "make oldconfig" automatically.
I would hate to be surprised with I do "make >build.out 2>&1",
only to find in a couple of hours that it was hanging on input.

-- Pete
