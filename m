Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSIED3e>; Wed, 4 Sep 2002 23:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSIED3e>; Wed, 4 Sep 2002 23:29:34 -0400
Received: from f241.law7.hotmail.com ([216.33.237.241]:65286 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S316705AbSIED3d>;
	Wed, 4 Sep 2002 23:29:33 -0400
X-Originating-IP: [216.251.50.73]
From: "sakib mondal" <sakib@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: hang at "bringing up interface lo:"
Date: Thu, 05 Sep 2002 03:34:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F241ur2iz2Mb1s7nlT200001857@hotmail.com>
X-OriginalArrivalTime: 05 Sep 2002 03:34:04.0031 (UTC) FILETIME=[151058F0:01C2548D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am runing RH linux-2.4.7-10 on a Dell Optiplex GX110 box (with 256Mb RAM). 
The system worked fine with networking support. I then added a virtual 
network driver (similar to 
ftp://ftp.linux.it/pub/People/Rubini/insane.tar.gz) to the kernel. (There is 
no change made to drivers/net/loopback.c). I compile the kernel in usual 
steps (make dep, make clean, make bzImage, make modules, make 
modules_install). The compilation works fine. However, when I am booting the 
new kernel image, the system hangs at the prompt "bringing up interface 
lo:". It does not echo "[OK]".
The system boots fine in single user mode. When I ran
"/etc/rc.d/init.d/network start", it got stuck at "./ifup ifcfg-lo".
Infact, in the ifup script, it is halting at "ip addr add 
${IPADDR}/${PREFIX} brd
${BROADCAST:-+} dev ${REALDEVICE} .." called to add adrress for lo. I
checked that it is correctly using IPADDR=127.0.0.1.

Since the system works fine with old kernel image, I guess the problem is 
with the new kernel image. I shall appreciate any pointer on what may go 
wrong.

TIA.

Regards
Sakib



_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

