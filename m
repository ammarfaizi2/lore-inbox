Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUEGWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUEGWYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUEGWYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:24:55 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:38057 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S263826AbUEGWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:24:54 -0400
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OPERA] Another potential error detected by static analysis tool (2.6.4)
Date: Fri, 7 May 2004 17:22:49 -0500
Message-ID: <001101c43481$d49756d0$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040507001407.GK9037@lorien.prodam>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version: 2.6.4
Files:
/arch/alpha/kernel/irq.c

--- 539,547 ----
  #ifdef CONFIG_SMP
        if (i == 0) {
                seq_puts(p, "           ");
!               for (i = 0; i < NR_CPUS; i++)
!                       if (cpu_online(i))
!                               seq_printf(p, "CPU%d       ", i);
                seq_putc(p, '\n');
        }
  #endif


Maybe change to:
*** 539,547 ****
  #ifdef CONFIG_SMP
        if (i == 0) {
                seq_puts(p, "           ");
!               for (j = 0; j < NR_CPUS; j++)
!                       if (cpu_online(j))
!                               seq_printf(p, "CPU%d       ", j);
                seq_putc(p, '\n');
        }
  #endif




OPERA Research Group
University of Illinois at Urbana-Champaign


