Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262984AbTC0Pnk>; Thu, 27 Mar 2003 10:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262994AbTC0Pnk>; Thu, 27 Mar 2003 10:43:40 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:59827 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262984AbTC0Pnj>;
	Thu, 27 Mar 2003 10:43:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16003.7879.340300.737153@gargle.gargle.HOWL>
Date: Thu, 27 Mar 2003 16:54:47 +0100
From: mikpe@csd.uu.se
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.21-pre5 correct scheduling of idle tasks [ all arch ]
In-Reply-To: <31961.1048659043@kao2.melbourne.sgi.com>
References: <31961.1048659043@kao2.melbourne.sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
 > There are several inconsistencies in the scheduling of idle tasks and,
 > for UP, tracking which task is on the cpu.  This patch standardizes
 > idle task scheduling across all architectures and corrects the UP
 > error, it is just a bug fix.
...
 > To make it worse, on UP a task is assigned to a cpu but never released.
 > Very quickly, all tasks are marked as currently running on cpu 0 :(.

->cpus_runnable and task_has_cpu() are SMP-only, as a quick grep
through 2.4.20 will tell you. There is no UP bug here to fix.

/Mikael
