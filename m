Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTCGIUE>; Fri, 7 Mar 2003 03:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbTCGIUD>; Fri, 7 Mar 2003 03:20:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19622 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261449AbTCGIUC>; Fri, 7 Mar 2003 03:20:02 -0500
Date: Fri, 07 Mar 2003 00:30:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       ricklind@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: NUMA scheduler broken
Message-ID: <324180000.1047025830@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something in current -bk breaks the NUMA scheduler.

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
             2.5.64-align       46.29      129.38      567.02     1504.75
                2.5.64-bk      153.04       49.05      558.30      395.00

Looks like it's not node-balancing at all and just using one node.
However, I spent a few minutes looking, and can't see anything obvious
that would have caused it.

Will look at it some more tommorow when I wake up, but if any of you
can see what's broken of the top of your head ...

M.


