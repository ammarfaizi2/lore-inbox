Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273236AbRINAir>; Thu, 13 Sep 2001 20:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273238AbRINAih>; Thu, 13 Sep 2001 20:38:37 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:27264 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S273236AbRINAiW>; Thu, 13 Sep 2001 20:38:22 -0400
Date: Fri, 14 Sep 2001 01:38:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Athlon problems fixed tweaking BIOS memory settings
Message-ID: <Pine.SOL.3.96.1010914012859.21012B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I had a few random crashes on my Athlon EPOX 8KTA3 mobo Athlon 1.33GHz
(BIOS from 06/14/2001) and Alan Cox suggested to run memtest as the oops
apparently looked like memory corruption. Sure enough memtest showed
problems above 256MiB but swapping the chips around still showed problems
above 256MiB which meant it couldn't be the chips at fault (failing tests
were 5 and 8 in memtest86 supplied with SuSE 7.2). 

Playing with the memory settings I found that using the "DRAM
Timing by SPD" option was unstable but setting it to manual and using the
settings: 133MHz, CL2, Bank interleave disabled as well as Pre charge to
active 3T, active to precharge 6T, active to cmd 3T. Makes it fully
stable even with Page-Mode enabled.

Changing the precharge/act/cmd value to faster caused increasing amounts
of errors in memtest to appear and enabling Timing by SPD did the same.
Memory now running at 23.1 MiB/sec according to memtest86 compared to 26
MiB/sec at previous, faster but unstable settings.

It seems there is some kind of problem with the "Timing by SPD" option. 
Also no matter what the settings are the system is always error free below
256MiB, which means that might explain why some people are having problems
and some are not... Until I upgraded the 256 to 768MiB I didn't have any
problems.

Just a datapoint...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

