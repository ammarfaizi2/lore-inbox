Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUAHNhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUAHNhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:37:45 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:12564 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264384AbUAHNhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:37:43 -0500
Date: Thu, 8 Jan 2004 05:39:01 -0800
From: Paul Jackson <pj@sgi.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Joe Korty <joe.korty@ccur.com>, Andrew Morton <akpm@osdl.org>
Subject: Broken big-endian SMP /proc/irq/prof_cpu_mask (2.6.0-mm1)?
Message-Id: <20040108053901.70ef9012.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you running 2.6.0-mm1 or later on a big-endian SMP box?

If so, I probably broke your file /proc/irq/prof_cpu_mask file
(and /proc/irq/<pid>/smp_affinity files as well ...).

Could you cat out /proc/irq/prof_cpu_mask for me, if you have
such a box, and tell me if the bytes are backward?  Please also
indicate your hardware architecture and number of CPUs, just
so I can be sure I am on track here.

If say you have 4 CPUs, then seeing something in the range of "1" to "f"
would be good news, but seeing some multiple of 1000000 would be bad
news.

For further details, see the lkml thread started yesterday
by joe.korty@ccur.com:

  Subject: seperator error in __mask_snprintf_len

If I have broken this as I suspect, I will prepare a patch for Andrew
shortly that fixes it.

Thanks for you assistance.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
