Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTHBNqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTHBNqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:46:34 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:52913 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S267576AbTHBNqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:46:32 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: advansys.c problems in 2.6.0-test2
Date: Sat, 2 Aug 2003 09:46:30 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308020946.30051.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.9.38] at Sat, 2 Aug 2003 08:46:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

As suggested earlier, I've made the scsi support a module so
that the rest of the system can boot, and the errant scsi 
driver then modprobed in.

During the compile, these warnings are issued:
--
  CC [M]  drivers/i2c/i2c-sensor.o
drivers/i2c/i2c-sensor.c: In function `i2c_detect':
drivers/i2c/i2c-sensor.c:54: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
--
  CC [M]  drivers/scsi/advansys.o
drivers/scsi/advansys.c: In function `advansys_detect':
drivers/scsi/advansys.c:4622: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/advansys.c: In function `AscSearchIOPortAddr11':
drivers/scsi/advansys.c:10004: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
--
sensors doesn't work but I can live with that for a bit.
This mobo has never run at less than 168F on the cpu,
and I have thermaltake's best on it.  The cpu runs 100%
doing setiathome full time.

However, after the bootup, an attempt to 'modprobe advansys'
will first do a bus reset, then find the tape drive as usual,
and then hang the process while attempting another bus reset.
Occasionally, not everytime, it will output a message about
a bad pointer.

And the scsi stuff I can't do without.  I have sent a msg
to what used to be advansys, but have not rx'd a reply as
its the weekend for 9-5 types.

This driver has been best described as bulletproof up till
now.

How should I proceed?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

