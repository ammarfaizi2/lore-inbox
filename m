Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTHCKAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbTHCKAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:00:15 -0400
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:22402 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP id S271112AbTHCKAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:00:11 -0400
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun,  3 Aug 2003 03:00:02 -0700 (PDT)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mathieu.Malaterre@creatis.insa-lyon.fr
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock
 performance)
In-Reply-To: <20030802144422.111d6893.akpm@osdl.org>
References: <16171.31418.271319.316382@kali.zeta-soft.com>
	<20030802144422.111d6893.akpm@osdl.org>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16172.14411.843546.121234@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@osdl.org>
   Date: Sat, 2 Aug 2003 14:44:22 -0700

   It is a problem which has been solved for a year at least.  Try
   running one of Andrea's kernels, from

   ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4

   The most important patch for you is 10_inode-highmem-2.

I tried that patch by itself and it appeared to make a noticeable
improvement, but it was far from a complete fix.

So next I tried the SuSE 8.2 kernel.  It is clearly *much* better, and I see
that Andrea in fact did a bit of work on `mm/vmscan.c'.  The key patch
appears to be `05_vm_06_swap_out-3', but it's possible that several or all
of the `05_vm_*' patches are helpful.

I see that even the very most recent Red Hat kernel (2.4.20-19.7, released
only two weeks ago) does not seem to have these fixes.  (I wasn't running Red
Hat -- my machine started out with SuSE 7.3, and I hand-upgraded it to
2.4.18 -- but Mathieu Malaterre, who is CCed above and whose query to me
about the problem got me started looking at it again, is using Red Hat.)

So I strongly urge the powers that be to include these patches in 2.4.22.

-- Scott
