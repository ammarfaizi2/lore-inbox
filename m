Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTFPKjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 06:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTFPKjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 06:39:33 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:35857 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263587AbTFPKjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 06:39:32 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.71 net/built-in.o : undefined reference to `register_cpu_notifier'
Date: Mon, 16 Jun 2003 18:42:25 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306161840.47388.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      net/ipv4/netfilter/ipt_REDIRECT.o
  CC      net/ipv4/netfilter/ipt_LOG.o
  CC      net/ipv4/netfilter/ipt_ULOG.o
  CC      net/ipv4/netfilter/ipt_TCPMSS.o
  CC      net/ipv4/netfilter/arp_tables.o
  CC      net/ipv4/netfilter/arptable_filter.o
  LD      net/ipv4/netfilter/ip_conntrack.o
  LD      net/ipv4/netfilter/built-in.o
  LD      net/ipv4/built-in.o
  LD      net/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1

net/built-in.o(.init.text+0x1b2): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
make: *** [.tmp_vmlinux1] Error 1

Added to net/core/flow.c

#include <linux/cpu.h>

Compiled OK, but netfilter not tested.

Regards
Michael

-- 
Powered by linux-2.5.71, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt


