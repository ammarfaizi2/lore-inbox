Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbTCJRfC>; Mon, 10 Mar 2003 12:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbTCJRfC>; Mon, 10 Mar 2003 12:35:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56992 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261379AbTCJRfB>; Mon, 10 Mar 2003 12:35:01 -0500
Date: Mon, 10 Mar 2003 09:45:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@muc.de>
Subject: Dcache hash distrubition patches
Message-ID: <10280000.1047318333@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Andi for the distribution count patches. I did some quick
numbers with this, just by running "find / | xargs ls -l > /dev/null"
to populate the cache, then dumped the numbers out.

larry:~# grep dentry /proc/slabinfo
dentry_cache      880531 884880    160 36870 36870    1 :  248  124

  count length
 444569 0
 381295 1
 163442 2
  46937 3
  10042 4
   1747 5
    253 6
     30 7
      5 8

Conclusion: the hash distribution (for this simple test) looks fine
to me.

M.
