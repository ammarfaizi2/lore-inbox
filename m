Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUK2W74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUK2W74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUK2W4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:56:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52729 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261871AbUK2Wzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:55:38 -0500
Message-ID: <41ABA8E5.4060504@mvista.com>
Date: Mon, 29 Nov 2004 14:55:33 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: A problem with xconfig
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In looking at the makefile history, it would appear that libkconfig.so has been 
deleted from the build.  It seems, however, that qconf has not gotten the message:

  make O=/usr/src/ver/makena/obj/  xconfig ARCH=i386
   HOSTCXX scripts/kconfig/qconf.o
   HOSTLD  scripts/kconfig/qconf
scripts/kconfig/qconf arch/i386/Kconfig
./scripts/kconfig/libkconfig.so: cannot open shared object file: No such file or 
directory
make[2]: *** [xconfig] Error 1
make[1]: *** [xconfig] Error 2
make: *** [xconfig] Error 2

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

