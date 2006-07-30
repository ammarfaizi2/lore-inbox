Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWG3C0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWG3C0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 22:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWG3C0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 22:26:18 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:56264 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751083AbWG3C0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 22:26:18 -0400
Message-ID: <44CC18B2.4040309@lwfinger.net>
Date: Sat, 29 Jul 2006 21:25:54 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: V2.6.18-rc2-latest git compilation fails on i386
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the latest i386 kernel from Linus's tree with CONFIG_STACK_UNWIND
defined, the following compilation error occurs:

   CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c: In function ‘show_trace_log_lvl’:
arch/i386/kernel/traps.c:193: error: invalid type argument of ‘->’
arch/i386/kernel/traps.c:196: error: invalid type argument of ‘->’
arch/i386/kernel/traps.c:197: error: invalid type argument of ‘->’

Using git's bisect capability, the bad commit is

commit c97d20a6c51067a38f53680d9609b4cf2867d077
Author: Andi Kleen <ak@suse.de>
Date:   Fri Jul 28 14:44:57 2006 +0200

     [PATCH] i386: Do backtrace fallback too

     Similar patch to earlier x86-64 patch. When the dwarf2 unwinder fails
     dump the left over stack with the old unwinder.

     Also some clarifications in the headers.

     Signed-off-by: Andi Kleen <ak@suse.de>
     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
