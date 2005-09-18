Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVIROqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVIROqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIROqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:46:46 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:61309 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751216AbVIROqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:46:46 -0400
Date: Sun, 18 Sep 2005 10:46:46 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: later kernels vs ntpd
To: linux-kernel@vger.kernel.org
Message-id: <200509181046.46637.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm observing that the last time ntpd logged that it was synchronized
with a time src, was:

6 Aug 17:44:36 ntpd[1886]: synchronized to 140.221.8.88, stratum=1

This was about a week before I left for month long trip, and I left it
running 2.6.13-rc6 which had been stable for several days prior to my
leaving.  In early September, I had to lead the missus thru a reboot
because the system time had jumped to some other time zone and the
heyu based lighting automation was afu.  That seemed to fix it till I
got back on the 14th.  At that time I noted that my watch appeared to be 
off
by several minutes.  The next day I did a 'service ntpd restart',
which backed the system time up about 4 minutes, bringing my watch a
lot closer.

Then I noticed that yesterday, before I built and installed 2.6.13.1,
that ntpd was apparently not synching.  A restart, which runs ntpdate
to crash set the clocks, does work, but ntpd is not.  I haven't
changed anything in the configs for ntpd in several months.

Historicly, this box has lost track of what time zone its on on
several occasions, but I believe this is a seperate problem.

Is anyone else having ntpd synch problems?  Take a look at
your /var/log/ntpd.log just for grins.  All I'm getting is the
restart messages, like these:

18 Sep 10:41:44 ntpd[17787]: ntpd exiting on signal 15
18 Sep 10:37:07 ntpd[29714]: running as uid(38)/gid(38)
euid(38)/egid(38).

>From the restart I just did, note the time reset of over 4 minutes.

>From the dates on my /boot/vmlinuz* files, it worked for 2.6.13-rc5,
but not for rc6 & (apparently) later.

Comments anybody?

I'm going to reboot to an older kernel (2.6.13-rc5) as a check, if
ntpd starts working, I'll advise here.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


