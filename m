Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTEBHDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbTEBHDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 03:03:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57673 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261912AbTEBHDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 03:03:05 -0400
Date: Fri, 2 May 2003 00:15:26 -0700
Message-Id: <200305020715.h427FQg10159@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Your DSO patch..
In-Reply-To: Linus Torvalds's message of  Thursday, 1 May 2003 23:58:14 -0700 <Pine.LNX.4.44.0305012352320.5606-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: Leona, I want to CONFESS things to you..  I want to WRAP you in a
   SCARLET ROBE trimmed with POLYVINYL CHLORIDE..  I want to EMPTY
   your ASHTRAYS...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I pushed the thing out anyway, in the expectation that it's something 
> stupid and you'll go "Doh!" and fix it asap. But because it's pushed out, 
> please go Doh! on linux-kernel, so that others get the fix too.

D'oh!  My patch didn't include the new file:

--- stock-2.5.68/arch/i386/kernel/vsyscall.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.68/arch/i386/kernel/vsyscall.S	Wed Apr 23 02:14:57 2003
@@ -0,0 +1,15 @@
+#include <linux/init.h>
+
+__INITDATA
+
+	.globl vsyscall_int80_start, vsyscall_int80_end
+vsyscall_int80_start:
+	.incbin "arch/i386/kernel/vsyscall-int80.so"
+vsyscall_int80_end:
+
+	.globl vsyscall_sysenter_start, vsyscall_sysenter_end
+vsyscall_sysenter_start:
+	.incbin "arch/i386/kernel/vsyscall-sysenter.so"
+vsyscall_sysenter_end:
+
+__FINIT
