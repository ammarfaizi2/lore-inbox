Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262249AbRERF5Y>; Fri, 18 May 2001 01:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbRERF5O>; Fri, 18 May 2001 01:57:14 -0400
Received: from vpn.moodlogic.com ([64.81.60.70]:20463 "EHLO uzo.telecoma.net")
	by vger.kernel.org with ESMTP id <S262249AbRERF5E>;
	Fri, 18 May 2001 01:57:04 -0400
Date: Fri, 18 May 2001 08:33:05 +0200
From: firenza@gmx.net
To: linux-kernel@vger.kernel.org
Subject: java/old_mmap allocation problems...
Message-ID: <20010518083305.C7657@telecoma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

i'm having problems to convince java (1.3.1) to allocate more
than 1.9gb of memory on 2.4.2-ac2 (SMP/6gb phys mem) or more
than 1.1gb on 2.2.18 (SMP/2gb phys mem)...

modifing /proc/sys/vm parameters didn't help either... the fact
that i can allocate more memory under 2.4 than under 2.2 lets
me hope that there is some possible kernel/vm tweaking that
would increase those limits...

any pointers would be greatly appreciated!

cheers,
-firenza

PS:

strace snippet of "java -Xmx2g" on the 2.4 system
brk(0x8057000)                          = 0x8057000
old_mmap(NULL, 163840, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x43691000
old_mmap(NULL, 2181038080, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = -1 ENOMEM 

strace snippet of "java -Xmx1500m" on the 2.2 system
old_mmap(0x2e082000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2e082000
old_mmap(NULL, 163840, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2e102000
old_mmap(NULL, 1606418432, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = -1 ENOMEM 

