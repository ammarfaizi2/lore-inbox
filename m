Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUEZScC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUEZScC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUEZSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:30:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265767AbUEZSam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:30:42 -0400
Date: Wed, 26 May 2004 11:30:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: was Re: VIA "Velocity" Gigabit ethernet driver
Message-Id: <20040526113000.09ccc390.davem@redhat.com>
In-Reply-To: <20040526174018.GA29119@devserv.devel.redhat.com>
References: <20040526174018.GA29119@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 13:40:18 -0400
Alan Cox <alan@redhat.com> wrote:

> It should work on both 32 and 64bit little endian, it won't work on big
> endian boxes yet.

64-bit eh? :-)

--- velocity.h.~1~	2004-05-26 09:58:00.000000000 -0700
+++ velocity.h	2004-05-26 11:28:51.727665416 -0700
@@ -1628,8 +1628,8 @@
 	enum chip_type chip_id;
 
 	struct mac_regs * mac_regs;
-	u32 memaddr;
-	u32 ioaddr;
+	unsigned long memaddr;
+	unsigned long ioaddr;
 	u32 io_size;
 
 	u8 rev_id;
