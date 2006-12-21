Return-Path: <linux-kernel-owner+w=401wt.eu-S1161076AbWLUAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWLUAPu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWLUAPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:15:49 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:61347 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161076AbWLUAPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:15:48 -0500
Date: Wed, 20 Dec 2006 19:15:45 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/10] local_t : adding and standardising atomic primitives
Message-ID: <20061221001545.GP28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:14:24 up 119 days, 21:22,  6 users,  load average: 3.18, 2.26, 1.62
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches extend and standardise local_t operations on each architectures,
allowing a rich set of atomic operations to be done on per-cpu data with
minimal performance impact. On some architectures, there seems to be no
difference between the SMP and UP operation (same memory barriers, same
LOCking), local.h simply includes asm-generic/local.h, which removes duplicated
code.

These patches applies on 2.6.20-rc1-git7.
It depends on the patch "atomic.h : standardising atomic primitives"

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
