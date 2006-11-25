Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967178AbWKYUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967178AbWKYUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967177AbWKYUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:42:26 -0500
Received: from smtp-out.google.com ([216.239.45.12]:39104 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S967178AbWKYUmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:42:25 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:content-type:content-transfer-encoding;
	b=HsHpDhICpj2bfQ/3G+x5y5YVNHjmpSvXnr5lwwpmUlptNbyQMx3sAT9fduNX0xPZS
	KWjHcv+/dBzrBO1e7sZKA==
Message-ID: <4568A992.6090404@google.com>
Date: Sat, 25 Nov 2006 12:37:38 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>
Subject: Compile failure since 2.6.19-rc6-git5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-git4 was fine. -git5 and later are broken.
AFAICS, it was this change: 700f9672c9a61c12334651a94d17ec04620e1976

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=700f9672c9a61c12334651a94d17ec04620e1976

This config on x86_64:
http://test.kernel.org/abat/62550/build/dotconfig

results in this compile failure:
http://test.kernel.org/abat/62550/debug/test.log.0

last bits are:

Building modules, stage 2.
   MODPOST 1139 modules
WARNING: "spin_lock_irqsave_nested" [net/irda/irda.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
11/22/2006-06:30:50 Build the modules. Failed rc = 2
11/22/2006-06:30:50 build: kernel build Failed rc = 1
Failed and terminated the run
11/22/2006-06:30:51 command complete: (1) rc=126 (TEST ABORT)
  Fatal error, aborting autorun
