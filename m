Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUEOOhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUEOOhC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUEOOhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:37:02 -0400
Received: from aun.it.uu.se ([130.238.12.36]:14537 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262625AbUEOOhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:37:00 -0400
Date: Sat, 15 May 2004 16:36:51 +0200 (MEST)
Message-Id: <200405151436.i4FEap0l001327@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: shai@ftcon.com
Subject: RE: [PATCH][6/7] perfctr-2.7.2 for 2.6.6-mm2: global-mode counters
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 17:51:35 -0700, Shai Fultheim wrote:
>Can you use DEFINE_PER_CPU instead of:
>
>+static struct gperfctr per_cpu_gperfctr[NR_CPUS] __cacheline_aligned;
>
>?

Yes, I will make that change.

The driver used to be buildable as a module, and per_cpu()
didn't (doesn't?) work in modules.

/Mikael
