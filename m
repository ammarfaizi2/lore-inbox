Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbTIKEtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbTIKEtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:49:16 -0400
Received: from ns1.open.org ([199.2.104.1]:18835 "EHLO open.org")
	by vger.kernel.org with ESMTP id S266065AbTIKEtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:49:11 -0400
Message-ID: <3F5A014E.2040000@open.org>
Date: Sat, 06 Sep 2003 08:46:22 -0700
From: Hal <pshbro@open.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3) Gecko/20030723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: platforms/willow.h included but not found in arch/ppc/platforms/mpc82xx.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] arch/ppc/platforms/mpc82xx.h: platforms/willow.h not found.

[2]

In arch/ppc/platforms/mpc82xx.h line 33 platforms/willow.h is included. 
This file does not exist.

[3] arch/ppc/kernel/asm-offsets.s include/asm/io.h include/asm/mpc8260.h 
platforms/willow.h

[4] 2.6.0-test5-bk1

[5]

  CC      arch/ppc/kernel/asm-offsets.s
  In file included from include/asm/mpc8260.h:12,
      from include/asm/io.h:32,
      from arch/ppc/kernel/asm-offsets.c:21:
  arch/ppc/platforms/mpc82xx.h:33:30: platforms/willow.h: No such file 
or directory
  make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
  make: *** [arch/ppc/kernel/asm-offsets.s] Error 2

[6] make allyesconfig; make

[7] Gentoo Linux

[7.1]

Linux darkstar.example.net 2.4.20-ben10 #11 Fri Sep 5 09:24:51 PDT 2003 
ppc  750FX GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.25
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         ipt_LOG ipt_state ipt_ttl iptable_filter 
iptable_nat ip_conntrack ip_tables

[7.2]

cpu             : 750FX
temperature     : 12 C (uncalibrated)
clock           : 700MHz
revision        : 1.18 (pvr 7000 0112)
bogomips        : 1389.36
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld


