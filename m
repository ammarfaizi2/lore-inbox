Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284200AbRLUOIQ>; Fri, 21 Dec 2001 09:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283759AbRLUOII>; Fri, 21 Dec 2001 09:08:08 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:51082 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281865AbRLUOH5>; Fri, 21 Dec 2001 09:07:57 -0500
Date: Fri, 21 Dec 2001 09:11:04 -0500
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221091104.A120@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running "dbench 32" on 2.5.2-pre1:

I noticed the test was taking much longer than usual,
and I could not do a new "login".  

vmstat 8 looked like this:

r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs us  sy  id
0 34  1      0 222504  12248 736088   0   0     0     0  103    59 0   0 100
1 34  1      0 222504  12248 736088   0   0     0     0  100    56 0   0 100
0 34  1      0 222504  12248 736088   0   0     0     0  103    59 0   0 100

<sysrq Sync Umount> did not print their "done" messages.
The "b" and "w" columns when up though:

r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs us  sy  id
0 37  3      0 222456 12280 736092   0   0     0     0  222   269   0   0 100

There was no Oops.
2.5.1-dj3 completed dbench normally.

Configs between the 2 kernels:
diff 2.5.2-pre1 2.5.1-dj3
> CONFIG_IP_NF_QUEUE=m

2.5.1-pre1[01] and 2.5.1-final did not exhibit this behavior.

Hardware:
1333 Athlon
1GB RAM

CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
-- 
Randy Hron

