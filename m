Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSJSKUA>; Sat, 19 Oct 2002 06:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265588AbSJSKUA>; Sat, 19 Oct 2002 06:20:00 -0400
Received: from d181.dhcp212-198-6.noos.fr ([212.198.6.181]:45575 "EHLO
	vawis.net") by vger.kernel.org with ESMTP id <S265587AbSJSKT6>;
	Sat, 19 Oct 2002 06:19:58 -0400
Date: Sat, 19 Oct 2002 12:27:16 +0200
From: Thierry Mallard <shaman@vawis.net>
To: Helge Hafting <helge.hafting@broadpark.no>
Cc: linux-kernel@vger.kernel.org
Subject: already fixed (was 2.5.44 compile failure, net/ipv4/raw.c)
Message-ID: <20021019102716.GA11434@hobbes.local.vawis.net>
References: <3DB12F8F.86C0B2E0@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3DB12F8F.86C0B2E0@broadpark.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford <skip.ford@verizon.net> already replied for this :

net/ipv4/raw.c needs to include netfilter_ipv4.h instead of just
netfilter.h

--- linux/net/ipv4/raw.c~       Sat Oct 19 00:47:05 2002
+++ linux/net/ipv4/raw.c        Sat Oct 19 00:47:11 2002
@@ -64,7 +64,7 @@
#include <net/raw.h>
#include <net/inet_common.h>
#include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>

struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
rwlock_t raw_v4_lock = RW_LOCK_UNLOCKED;

Regards,

-- 
Thierry Mallard
http://vawis.net
     
