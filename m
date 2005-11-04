Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbVKDK0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVKDK0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKDK0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:26:11 -0500
Received: from 80-218-222-113.dclient.hispeed.ch ([80.218.222.113]:15510 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S1161136AbVKDK0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:26:09 -0500
Message-ID: <436B3730.2090705@steudten.org>
Date: Fri, 04 Nov 2005 11:25:52 +0100
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: LinuxAlpha <linux-alpha@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: ALPHA: missing reference to barrier()
Content-Type: multipart/mixed;
 boundary="------------080507010702010705070106"
X-Mailer: Mailer
X-Check: 3038b5ec1c21490deb1855c3587be051 on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080507010702010705070106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ONLY for linux ALPHA:

Please add patch to the source tree..

Hello

In the kernel source 2.6.14 from kernel.org build with the given config1, the
symbol barrier() is missing in linux/include/asm-alpha/atomic.h with gcc 4.0.1 from
FC4.

This is defined in linux/compiler.h or asm/compiler.h.

PATCH:
------------------
--- include/asm-alpha/atomic.h.orig     2005-11-03 18:45:21.000000000 +0100
+++ include/asm-alpha/atomic.h  2005-11-03 18:45:46.000000000 +0100
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_ATOMIC_H
 #define _ALPHA_ATOMIC_H

+#include <asm/compiler.h>
 #include <asm/barrier.h>

 /*
-------------------

CC      fs/nfsctl.o
In file included from include/linux/file.h:8,
                 from fs/nfsctl.c:8:
include/asm/atomic.h: In function 'atomic_add_return':
include/asm/atomic.h:105: warning: implicit declaration of function 'barrier'
  CC      fs/binfmt_script.o
  CC      fs/binfmt_elf.o

 CC      net/ipv4/raw.o
In file included from net/ipv4/raw.c:43:
include/asm/atomic.h: In function 'atomic_add_return':
include/asm/atomic.h:105: warning: implicit declaration of function 'barrier'
  CC      net/ipv4/udp.o

net/built-in.o(.text+0x580e0): In function `raw_rcv_skb':
: undefined reference to `barrier'
net/built-in.o(.text+0x580e4): In function `raw_rcv_skb':
: undefined reference to `barrier'
net/built-in.o(.text+0x58104): In function `raw_rcv_skb':
: undefined reference to `barrier'
net/built-in.o(.text+0x58108): In function `raw_rcv_skb':
: undefined reference to `barrier'
net/built-in.o(.text+0x58650): In function `raw_rcv':




--------------080507010702010705070106
Content-Type: application/x-gzip;
 name="config1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config1.gz"

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
vsUfEBBeySJcj3n6/wHJV8GNfCoAAA==
--------------080507010702010705070106--
