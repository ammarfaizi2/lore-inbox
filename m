Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRAHTMx>; Mon, 8 Jan 2001 14:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbRAHTMn>; Mon, 8 Jan 2001 14:12:43 -0500
Received: from topaz.3com.com ([192.156.136.158]:35534 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S129818AbRAHTM1>;
	Mon, 8 Jan 2001 14:12:27 -0500
X-Lotus-FromDomain: 3COM
From: Steven_Snyder@3com.com
To: linux-kernel@vger.kernel.org
Message-ID: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Date: Mon, 8 Jan 2001 13:11:19 -0600
Subject: Shared memory not enabled in 2.4.0?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For some reason shared memory is not being enabled on my system running kernel
v2.4.0 (on RedHat v6.2,  with all updates applied).

Per the documentation I have this line in my /etc/fstab:

     none  /dev/shm  shm defaults  0 0

Yes, I have created this subdirectory:

     # ls -l /dev | grep shm
     drwxrwxrwt    1 root     root            0 Jan  7 11:54 shm

No complaints are seen at startup, yet I still have no shared memory:

     # cat /proc/meminfo
             total:    used:    free:  shared: buffers:  cached:
     Mem:  130293760 123133952  7159808        0 30371840 15179776
     Swap: 136241152        0 136241152
     MemTotal:       127240 kB
     MemFree:          6992 kB
     MemShared:           0 kB
     Buffers:         29660 kB
     Cached:          14824 kB
     Active:           3400 kB
     Inact_dirty:     37872 kB
     Inact_clean:      3212 kB
     Inact_target:        4 kB
     HighTotal:           0 kB
     HighFree:            0 kB
     LowTotal:       127240 kB
     LowFree:          6992 kB
     SwapTotal:      133048 kB
     SwapFree:       133048 kB

Is there some configuration option which I missed?  Some trick not mentioned in
the doc?

Thank you.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
