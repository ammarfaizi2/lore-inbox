Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131419AbRCPXeQ>; Fri, 16 Mar 2001 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRCPXeG>; Fri, 16 Mar 2001 18:34:06 -0500
Received: from quechua.inka.de ([212.227.14.2]:17994 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131419AbRCPXd5>;
	Fri, 16 Mar 2001 18:33:57 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: pivot_root & linuxrc problem
In-Reply-To: <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14e3if-0002od-00@sites.inka.de>
Date: Sat, 17 Mar 2001 00:33:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de> you wrote:
> Aha.. so that's it.  I've never been able to get /linuxrc to execute
> automagically.  I wonder why /linuxrc executes on Art's system, but
> not on mine.  I can call it whatever I want and it doesn't run unless
> I explicitly start it with init=whatever.

linuxrc is executed iff:

CONFIG_BLK_DEV_INITRD is defined
you actually have a initrd mounted
/dev/console can be found and opened
a executable "/linuxrc" is in the ramdisk

Note: initramdisks need to be set up and prepared by your boot loader or with
the right structure on your boot media. You also need to have a filesystem on
the initrd which the kernel can detect without modules. But kernel does not
need to be able to read from the boot device since the image is read by
bootloader (e.g. boot-prom or 16bit bios).

Greetings
Bernd
