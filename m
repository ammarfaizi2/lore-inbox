Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWCGJkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWCGJkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 04:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbWCGJkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 04:40:14 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42135
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1752125AbWCGJkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 04:40:12 -0500
Message-ID: <440D54F2.2080009@tglx.de>
Date: Tue, 07 Mar 2006 10:40:02 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was: realtime-preempt
 patch-2.6.15-rt18 issues)
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>    <20060306132442.GA12359@elte.hu> <4547.195.245.190.94.1141657830.squirrel@www.rncbc.org>
In-Reply-To: <4547.195.245.190.94.1141657830.squirrel@www.rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -rt19 doesn't compile here (either with CONFIG_EMBEDDED=y or not):

same problem here. Looks like a typo...
Am I right?

Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

--------------------------------------------------

--- slab.c.orig 2006-03-07 10:27:35.000000000 +0100
+++ slab.c      2006-03-07 10:28:17.000000000 +0100
@@ -700,7 +700,7 @@ static struct kmem_cache cache_cache = {
        .shared = 1,
        .buffer_size = sizeof(struct kmem_cache),
        .flags = SLAB_NO_REAP,
-       .spinlock = SPIN_LOCK_UNLOCKED(&cache_cache.spinlock),
+       .spinlock = SPIN_LOCK_UNLOCKED(cache_cache.spinlock),
        .name = "kmem_cache",
 #if DEBUG
        .obj_size = sizeof(struct kmem_cache),
