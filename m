Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277214AbRJINoe>; Tue, 9 Oct 2001 09:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJINoY>; Tue, 9 Oct 2001 09:44:24 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:61385 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S277214AbRJINoE>; Tue, 9 Oct 2001 09:44:04 -0400
From: rwhron@earthlink.net
Date: Tue, 9 Oct 2001 09:47:07 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: [LTP] VFS: brelse: started after 2.4.10-ac7 
Message-ID: <20011009094707.B4951@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


About 2 minutes into "runalltests.sh" on ltp, ac kernels after 2.4.10-ac7
give a message like:

Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer
Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer

Repeatability:   Good

Seen on:

2.4.10-ac8
2.4.10-ac10
2.4.10-ac10+eatcache

Not seen on:

2.4.10-ac4
2.4.10-ac7
2.4.11-pre2
2.4.11-pre6

Has occurred on every case with ac8 and ac10, and no test before.  

Doesn't happen on Linus kernels.

Does not occur on my laptop, which is ext2 only.

Did not occur on Athlon when /tmp was mounted as ext2.  
(LTP tests write a lot of files to /tmp).


I haven't tracked down which test generates the message yet, but it is
before the "personality" tests.


Configuration
-------------

Linux rushmore 2.4.10-ac10a #2 Tue Oct 9 00:42:57 EDT 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         cmpci ppp_deflate bsd_comp ppp_async ipt_state ipt_limit ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables



-- 
Randy Hron

