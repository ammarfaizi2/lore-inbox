Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTE0IEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTE0IEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:04:10 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:8530 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262687AbTE0IEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:04:09 -0400
Date: Tue, 27 May 2003 10:17:21 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: 2.4.21-rc2-ac3/CPU
Message-ID: <Pine.LNX.4.53.0305270954180.11708@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I would like to ask, that why kernel 2.4.21-rc2-ac3 can't find all CPU?
It's look like this:

On 2.4.21-rc3:

May 26 20:31:04 oceanic kernel: CPU0<T0:1329040,T1:1063232,D:0,S:265808,C:1329040>
May 26 20:31:04 oceanic kernel: CPU2<T0:1329040,T1:531616,D:0,S:265808,C:1329040>
May 26 20:31:04 oceanic kernel: CPU3<T0:1329040,T1:265808,D:0,S:265808,C:1329040>
May 26 20:31:04 oceanic kernel: CPU1<T0:1329040,T1:797424,D:0,S:265808,C:1329040>
May 26 22:11:55 oceanic kernel: CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm)XEON(tm) APIC version 16
May 26 22:11:55 oceanic kernel: CPU 1 (0x0600) enabledProcessor #6 Pentium 4(tm)XEON(tm) APIC version 16
May 26 22:11:55 oceanic kernel: CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm)XEON(tm) APIC version 16
May 26 22:11:55 oceanic kernel: CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm)XEON(tm) APIC version 16
May 26 22:11:55 oceanic kernel: 4 CPUs total
[...]
May 26 20:31:04 oceanic kernel: Total of 4 processors activated (21233.66 BogoMIPS).


On 2.4.21-rc2-ac3:

May 27 01:08:38 oceanic kernel: CPU0<T0:1329088,T1:886048,D:8,S:443032,C:1329096>
May 27 01:08:38 oceanic kernel: cpu: 1, clocks: 1329096, slice: 443032
May 27 01:08:38 oceanic kernel: CPU1<T0:1329088,T1:443024,D:0,S:443032,C:1329096>
May 27 01:08:38 oceanic kernel: migration_task 0 on cpu=0
May 27 01:08:38 oceanic kernel: migration_task 1 on cpu=1
[...]
May 27 01:08:38 oceanic kernel: WARNING: No sibling found for CPU 0.
May 27 01:08:38 oceanic kernel: WARNING: No sibling found for CPU 1.
May 27 01:08:38 oceanic kernel: Total of 2 processors activated (10616.83 BogoMIPS).


I'm using the same .config file except that 
2.4.21-rc2-ac3:
CONFIG_MPENTIUM4=y
2.4.21-rc3:
CONFIG_MPENTIUMIII=y
Anyway, I don't know, that which one is better choice? :)

If You want, I can send to you full dmesg or full .config file

-- 
lt
