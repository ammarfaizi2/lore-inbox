Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWJCFT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWJCFT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWJCFT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:19:58 -0400
Received: from ozlabs.org ([203.10.76.45]:44480 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965249AbWJCFT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:19:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.62198.476469.265990@cargo.ozlabs.ibm.com>
Date: Tue, 3 Oct 2006 15:19:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061002213347.8229b6fc.akpm@osdl.org>
References: <20061003010842.438670755@goop.org>
	<20061003010933.392428107@goop.org>
	<17697.58794.113796.925995@cargo.ozlabs.ibm.com>
	<20061002213347.8229b6fc.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> It makes it heaps better here.

The patch below should fix it properly.

> Did you try my .config on the g5?

Not yet; I can't find your .config in my inbox - maybe I deleted that
message by mistake.  Resend?

Paul.

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8adad14..40e5e0d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -503,7 +503,7 @@ #endif
 
 	mtmsr(msr);		/* restore interrupt enable */
 
-	return cmd != 'X';
+	return cmd != 'X' && cmd != EOF;
 }
 
 int xmon(struct pt_regs *excp)

