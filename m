Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285052AbRLLCaV>; Tue, 11 Dec 2001 21:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285053AbRLLCaK>; Tue, 11 Dec 2001 21:30:10 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:34313 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285052AbRLLCaA>; Tue, 11 Dec 2001 21:30:00 -0500
Date: Tue, 11 Dec 2001 18:32:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Near CPUs ...
Message-ID: <Pine.LNX.4.40.0112111806100.1500-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The multi queue scheduler i'm currently working on uses a balancing method
that relies on a metric table :

unsigned char cpus_dmap[NR_CPUS][NR_CPUS];

that lists metrics between CPUs, ie :

metric(I, J) = F(cpus_dmap[I][J])

and this is the easy part.
How to detect CPUs that are "near" ( on the same bus/mb ) on x86/ia64 hardware ?
Is the MP configuration data structured in a way that makes you understand
this mapping, ie :

HDR-ENTRY
BUS-ENTRY
CPU-ENTRY
...
BUS-ENTRY
...




- Davide




