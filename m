Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIUFiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 01:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTIUFiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 01:38:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:8716 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262349AbTIUFiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 01:38:23 -0400
Date: Sun, 21 Sep 2003 07:38:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: evil <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.2x
Message-ID: <20030921053816.GD589@alpha.home.local>
References: <3F6D134E.2080505@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6D134E.2080505@g-house.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 04:56:14AM +0200, evil wrote:
 
> the machine:
> Dual Athlon, 1GB RAM (HighMem enabled), gcc 3.3.1, libc 2.3.2,
> (Debian/Testing) some more infos are on:
> 
> http://nerdbynature.de/bits/freeze/config|cpuinfo|dmesg|lspci

Hmmm, there is a lot of hardware in this box. Have you tried disabling IDE ?
ServeRaid ? SymBIOS ? Your hangs may be related to an updatedb or slocate
indexing all your filesystems, and triggering a bug in one of those drivers.
Also, the DMESG shows that you have an AMD bug on your CPUs, and tells you
that if you have problems, you should restart with 'noapic'. Did you try it ?
You could also try to boot in 'nosmp' mode, and even with network unplugged.
I believe it will be relatively quick to find the problem if the system
usually hangs in no more than 3 minutes.

You may also have a defect in your RAM. Someone else here had problems since
2.4.20, and only when saving disks to tape. It was finally tracked down to
a RAM problem which only showed up on SMP with newer kernels which seem to
torture the hardware a bit more. So if your GB ram is 4*256, you can try to
remove 2 sticks and see what happens.

Hope this helps,
Willy

