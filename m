Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbUKXUUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUKXUUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUKXUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:20:55 -0500
Received: from pop.gmx.de ([213.165.64.20]:61087 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262823AbUKXUUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:20:50 -0500
Date: Wed, 24 Nov 2004 21:14:09 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: manfred@colorfullife.com, hugh@veritas.com
Cc: torvalds@osdl.org, michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
References: <20041123090449.1672494f.akpm@osdl.org>
Subject: Further shmctl() SHM_LOCK strangeness
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <7379.1101327249@www30.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred, Hugh,

While studying the RLIMIT_MEMLOCK stuff further, I came 
up with another observation: a process can perform a
shmctl(SHM_LOCK) on *any* System V shared memory segment, 
regardles of the segment's ownership or permissions,
providing the size of the segment falls within the 
process's RLIMIT_MEMLOCK limit.

Is this intended behaviour?  For most other System V IPC 
"ctl" operations the process must either:

1. be the owner of the object or have an appropriate 
   capability, or

2. have suitable permissions on the object.

Which of these two conditions applies depends on the
"ctl" operation.

Cheers,

Michael

-- 
NEU +++ DSL Komplett von GMX +++ http://www.gmx.net/de/go/dsl
GMX DSL-Netzanschluss + Tarif zum supergünstigen Komplett-Preis!
