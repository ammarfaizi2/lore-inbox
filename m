Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUCLCsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUCLCsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:48:12 -0500
Received: from cache1.telkomsel.co.id ([202.155.14.251]:36108 "EHLO
	cache1.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S261921AbUCLCsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:48:06 -0500
Subject: Badness in i82365
From: arief# <arief_m_utama@telkomsel.co.id>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079060352.3694.4.camel@damai.telkomsel.co.id>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 09:59:12 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Before, please cc your replies to me, as I'm not in the list right now. 

I got this whenever I'm doing '/etc/init.d/pcmcia stop'
on my Debian-Sid.

---cut---
kernel: Badness in device_release at drivers/base/core.c:86
kernel: Call Trace:
kernel:  [kobject_cleanup+152/154] kobject_cleanup+0x98/0x9a
kernel:  [__crc_sysdev_class_register+464695/704596]
         exit_i82365+0x39/0xf5 [i82365]
kernel:  [sys_delete_module+310/337] sys_delete_module+0x136/0x151
kernel:  [sys_munmap+68/100] sys_munmap+0x44/0x64
kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kernel:
kernel: Trying to free nonexistent resource <000003e0-000003e1>
kernel: pnp: Device 00:19 disabled.
kernel: unloading Kernel Card Services
---cut---

uname -a:
Linux damai 2.6.3 #2 Wed Mar 10 23:25:40 WIT 2004 i686 GNU/Linux

Also happened in 2.6.4-rc2.
Not yet tested in 2.6.4,
but a quick scans on the 2.6.4 patches, I didn't see any fix.

Any body knows about this?

TIA.
Best Regards,
-arief

