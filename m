Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTJVXzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTJVXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:55:21 -0400
Received: from ssa8.serverconfig.com ([209.51.129.179]:17831 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S261294AbTJVXzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:55:17 -0400
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: linux-kernel@vger.kernel.org
Subject: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Date: Wed, 22 Oct 2003 18:55:15 +0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310221855.15925.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I know you can select Pentium III, Pentium 4, Athlon, etc, under 
processor type when doing a 'make xconfig', but those selections do not 
translate into the appropriate -mcpu and -march flags.

While the kernel on x86 architecture can be optimized in terms of generic 
processor specifications (i.e. i386, i486, i586, i686), the kernel can't be 
optimized beyond a i686.

If you select Pentium III, the -march flag is set to i686.
If you select Pentium 4, the -march flag is set to i686.
If you select Athlon 4, the -march flag is set to i686.
If you select Athlon XP, the -march flag is set to i686.

It should be that...

If you select Pentium III, the -march flag is set to pentium3.
If you select Pentium 4, the -march flag is set to pentium4.
If you select Athlon 4, the -march flag is set to athlon-4.
If you select Athlon XP, the -march flag is set to athlon-xp.

I don't want to have to hand edit the makefiles just to optimize my kernel.  
I think this change is simple enough to do, and would allow kernel 
developers the option of processor-specific optimizations in the future.

TIA.

Joseph D. Wagner
