Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTDRE40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTDRE40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:56:26 -0400
Received: from [12.47.58.203] ([12.47.58.203]:9236 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262865AbTDRE4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:56:25 -0400
Date: Thu, 17 Apr 2003 22:08:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] mach_countup() fix
Message-Id: <20030417220859.6d1a0fcc.akpm@digeo.com>
In-Reply-To: <3E9F5EAD.2070006@pobox.com>
References: <3E9F5EAD.2070006@pobox.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 05:08:16.0934 (UTC) FILETIME=[8566A460:01C30568]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Just booted into 2.5.67-BK-latest (plus my __builtin_memcpy patch). 
> Everything seems to be running just fine, so naturally one must nitpick 
> little things like being told my CPU is running at 0.000 Mhz.  :)
> 

Missing parentheses in mach_countup().


diff -puN include/asm-i386/mach-default/mach_timer.h~a include/asm-i386/mach-default/mach_timer.h
--- 25/include/asm-i386/mach-default/mach_timer.h~a	2003-04-17 22:02:12.000000000 -0700
+++ 25-akpm/include/asm-i386/mach-default/mach_timer.h	2003-04-17 22:02:49.000000000 -0700
@@ -40,7 +40,7 @@ static inline void mach_countup(unsigned
 {
 	*count = 0L;
 	do {
-		*count++;
+		(*count)++;
 	} while ((inb_p(0x61) & 0x20) == 0);
 }
 

_

