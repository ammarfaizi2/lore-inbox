Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTDKOJt (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTDKOJt (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:09:49 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:56947
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264363AbTDKOJt (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 10:09:49 -0400
Date: Fri, 11 Apr 2003 10:14:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.4] smp_call_function needs mb()
In-Reply-To: <Pine.LNX.4.50.0304110945240.540-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304111013480.540-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304110945240.540-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops i ended up including the 2.5 patch in the same email. This one should 
be fine to pipe through patch.

Index: linux-2.4.20/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20/arch/i386/kernel/smp.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 smp.c
--- linux-2.4.20/arch/i386/kernel/smp.c	11 Apr 2003 13:44:11 -0000	1.2
+++ linux-2.4.20/arch/i386/kernel/smp.c	11 Apr 2003 13:44:27 -0000
@@ -563,7 +563,7 @@ int smp_call_function (void (*func) (voi
 
 	spin_lock(&call_lock);
 	call_data = &data;
-	wmb();
+	mb();
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 

-- 
function.linuxpower.ca
