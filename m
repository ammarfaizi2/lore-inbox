Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265397AbRFWBYM>; Fri, 22 Jun 2001 21:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265528AbRFWBYB>; Fri, 22 Jun 2001 21:24:01 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:50704 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S265397AbRFWBXz>;
	Fri, 22 Jun 2001 21:23:55 -0400
Message-ID: <3B33EFC0.D9C930D5@bigfoot.com>
Date: Fri, 22 Jun 2001 19:24:16 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Annoying kernel behaviour
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I upgraded a fileserver to 2.4.5 because of the RAID support (the 0.90
patch I grabbed did not apply cleanly to 2.2.19, despite it being a fresh
copy).  Besides a nice speed increase (the EEPro now pumps 10 megs a second,
instead of 2 or 3), there is a problem with the video4linux in it.  The box
has a bttv card hooked up to a camera.  Under 2.2.19, Apache had mod_video
installed, which would produce a jpeg of the composite in on the card (a
cheapy CCD camera is hooked up).  Upon insmoding:
Module                  Size  Used by
bttv                   55184   0  (unused)
videodev                4864   2  [bttv]
i2c-algo-bit            7712   1  [bttv]
i2c-dev                 3904   0  (unused)
i2c-core               12656   0  [bttv i2c-algo-bit i2c-dev]

and accesing mod_video, the box locked up hard (not even sysrq worked).  And
when I rebooted, I found that some files is /etc were eaten -- even though
that partition is mounted with the sync option, and even though it'd had a
good 2-5 seconds the write the ~10k data file.

So why does bttv lock the box, and why does sync not sync?  I don't feel
like converting ~80gb to some other FS than ext2 just yet.

PS: I can't give an Oops because the DPMS mode on the console was on, and it
won't return when it locks up (perhaps turn on monitor as part of Oops
handling?).  Assuming there even was an oops.

PPS: Please CC me since I'm not on the list.
--
    www.kuro5hin.org -- technology and culture, from the trenches.
