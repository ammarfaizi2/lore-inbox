Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKABPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 20:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTKABPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 20:15:05 -0500
Received: from harddata.com ([216.123.194.198]:20112 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S262109AbTKABPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 20:15:01 -0500
Message-ID: <42692.216.123.194.211.1067649290.squirrel@www.harddata.com>
Date: Fri, 31 Oct 2003 18:14:50 -0700 (MST)
Subject: [Patch]Kernel 2.6.0-test9 compile on x86-64
From: <mark@harddata.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I must say this is my first experience with a 2.6 kernel and it is very
fast and responsive.

I found that when compiling the 2.6.0-test9 for an athlon64 that the
symbol "ip_compute_csum" was not found by several network modules
including sk98lin with concerned me in perticular. A quick google search
revealed that IA64 had a similar problem in test6 and that ksyms for
x86-64 need to export "ip_compute_csum" to fix the problem.

Here's a diff of the change I made.

$ pwd
/usr/src/linux-2.6.0-test9/arch/x86_64/kernel

$ diff x8664_ksyms.c x8664_ksyms.c~
217c217
< EXPORT_SYMBOL(ip_compute_csum);
---
>

After making this change I was able to recompile my kernel and it works
because I am using my SK9521 to send this email.

regards,

-- 
Mark Lane, CET
Hard Data Ltd www.harddata.com
mark@harddata.com
780-456-9771




