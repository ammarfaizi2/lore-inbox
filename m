Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274881AbTHPRxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274892AbTHPRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:53:55 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:37587 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S274881AbTHPRxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:53:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm2 gnomeradio, xawtv both fail
Date: Sat, 16 Aug 2003 13:53:53 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161353.53060.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.12.137] at Sat, 16 Aug 2003 12:53:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xawtv says it cannot open /dev/video0, and gnomeradio says it cannot 
open /dev/radio0.
I have this:
[root@coyote root]# xawtv
This is xawtv-3.74, running on Linux/i686 (2.6.0-test3-mm2)
can't open /dev/video0: No such device
v4l-conf had some trouble, trying to continue anyway
v4l2: open /dev/video0: No such device
v4l: open /dev/video0: No such device
no video grabber device available
[root@coyote root]# ls -l /dev/video*
lrwxrwxrwx    1 root     root            6 Jun 13 04:47 /dev/video -> 
video1
crw-------    1 root     root      81,   0 Aug 30  2002 /dev/video0
crw-------    1 root     root      81,   1 Aug 30  2002 /dev/video1
crw-------    1 root     root      81,  10 Jun  8 22:29 /dev/video10
crw-------    1 root     root      81,  11 Jun  8 22:29 /dev/video11
crw-------    1 root     root      81,  12 Jun  8 22:29 /dev/video12
crw-------    1 root     root      81,  13 Jun  8 22:29 /dev/video13
crw-------    1 root     root     172,   0 Aug 30  2002 /dev/video1394
crw-------    1 root     root      81,  14 Jun  8 22:29 /dev/video14
crw-------    1 root     root      81,  15 Jun  8 22:29 /dev/video15
crw-------    1 root     root      81,  16 Jun  8 22:29 /dev/video16
crw-------    1 root     root      81,   2 Aug 30  2002 /dev/video2
crw-------    1 root     root      81,   3 Aug 30  2002 /dev/video3
crw-------    1 root     root      81,   4 Jun  8 22:29 /dev/video4
crw-------    1 root     root      81,   5 Jun  8 22:29 /dev/video5
crw-------    1 root     root      81,   6 Jun  8 22:29 /dev/video6
crw-------    1 root     root      81,   7 Jun  8 22:29 /dev/video7
crw-------    1 root     root      81,   8 Jun  8 22:29 /dev/video8
crw-------    1 root     root      81,   9 Jun  8 22:29 /dev/video9

and this:
[root@coyote root]# gnomeradio
Storing Settings in GConf database
[root@coyote root]# ls -l /dev/radio*
lrwxrwxrwx    1 root     root            6 Nov 23  2002 /dev/radio -> 
radio0
crw-------    1 root     root      81,  64 Aug 30  2002 /dev/radio0
crw-------    1 root     root      81,  65 Aug 30  2002 /dev/radio1
crw-------    1 root     root      81,  66 Aug 30  2002 /dev/radio2
crw-------    1 root     root      81,  67 Aug 30  2002 /dev/radio3

i2c stuff is not working yet, may I assume these are interlocked?
I've not been able to make either i2c-2.8.0, or lm_sensors-2.8.0 
compile, partially because the name of the kernel version file in the 
lib/modules tree was changed for 2.6 and the makefiles cannot find 
it.

So whats next folks?

Oh, the expanded BUF_SHIFT? apparently works, but I took some other 
gingerbread out and dmesg this time is only 11k.  But I'll leave it 
till I get back in a couple of months.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

