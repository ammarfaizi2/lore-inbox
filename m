Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWFZSKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWFZSKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWFZSKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:10:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11218 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932298AbWFZSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:10:00 -0400
Date: Mon, 26 Jun 2006 11:09:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org,
       dsp@llnl.gov
Subject: Re: [rfc][patch] fixes for several oom killer problems
Message-Id: <20060626110933.8fe47858.pj@sgi.com>
In-Reply-To: <20060626162038.GB7573@wotan.suse.de>
References: <20060626162038.GB7573@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Paul Jackson <pj@sgi.com>

+	/*
+	 * If p's nodes don't overlap ours, it may still help to kill p
+	 * because p may have allocated or otherwise mapped memory on
+	 * this node before. However it will be less likely.
+	 */
+	if (!cpuset_excl_nodes_overlap(p))
+		points /= 4;

Good.


 int cpuset_excl_nodes_overlap(const struct task_struct *p)
 {
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
-	int overlap = 0;		/* do cpusets overlap? */
+	int overlap = 1;		/* do cpusets overlap? */

Good.

Thanks, Nick and Jan.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
