Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUHXTcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUHXTcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHXTav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:30:51 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8387 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268239AbUHXTag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:30:36 -0400
Message-ID: <412B9758.5050804@nortelnetworks.com>
Date: Tue, 24 Aug 2004 15:30:32 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ppc64 cross compiler hangs in infinite loop while compiling kernel/posix-timers.c
 optimised
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a crosstool-generated ppc64 cross compiler for ppc.  Specifically, its 
the 3.4.0 compiler.

Building with "V=1", the full command is:

powerpc64-linux-gnu-gcc -m64 -Wp,-MD,kernel/.posix-timers.o.d -nostdinc 
-iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes 
-Wno-trigraphs -fno-strict-aliasing -fno-common -msoft-float -pipe 
-Wno-uninitialized -mminimal-toc -mtraceback=none -mtune=power4 -funit-at-a-time 
-O2 -Wdeclaration-after-statement    -DKBUILD_BASENAME=posix_timers 
-DKBUILD_MODNAME=posix_timers -c -o kernel/.tmp_posix-timers.o kernel/posix-timers.c

This hangs.  If I remove the "-O2" portion, it compiles fine.  Obviously 
something is confusing it.  Anyone have any ideas?

Chris
