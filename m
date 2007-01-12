Return-Path: <linux-kernel-owner+w=401wt.eu-S1030257AbXALBnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbXALBnG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbXALBnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:43:05 -0500
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:39531 "EHLO
	tomts43-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030257AbXALBnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:43:04 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 00/10] local_t : adding and standardising local atomic primitives
Date: Thu, 11 Jan 2007 20:42:51 -0500
Message-Id: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_t : adding and standardising local atomic primitives

These patches extend and standardise local_t operations on each architectures,
allowing a rich set of atomic operations to be done on per-cpu data with
minimal performance impact. On architectures where there seems to be no
difference between the SMP and UP operation (same memory barriers, same
LOCKing), local.h simply includes asm-generic/local.h, which removes duplicated
code from the current kernel tree.

These patches apply on 2.6.20-rc4-git3.
It depends on the patches "atomic.h : standardising atomic primitives"

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

