Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWE3VHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWE3VHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWE3VHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:07:49 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:40917 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932472AbWE3VHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:07:48 -0400
Message-ID: <447CB407.9090805@ens-lyon.org>
Date: Tue, 30 May 2006 23:07:19 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: 2.6.17-rc5-mm1
References: <20060530022925.8a67b613.akpm@osdl.org>
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +node-hotplug-register-cpu-remove-node-struct.patch
> +node-hotplug-fixes-callres-of-register_cpu.patch
> +node-hotplug-fixes-callres-of-register_cpu-powerpc-warning-fix.patch
> +node-hotplug-register_node-fix.patch
>
>  NUMA node hotplugging updates
>   


Hi Andrew,

I had to apply the following patch to build this -mm on alpha.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice

Index: linux-mm/arch/alpha/kernel/setup.c
===================================================================
--- linux-mm.orig/arch/alpha/kernel/setup.c	2006-05-30 22:53:54.000000000 +0200
+++ linux-mm/arch/alpha/kernel/setup.c	2006-05-30 22:55:30.000000000 +0200
@@ -481,7 +481,7 @@
 		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
-		register_cpu(p, i, NULL);
+		register_cpu(p, i);
 	}
 	return 0;
 }


