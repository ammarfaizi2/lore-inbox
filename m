Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSBDJmk>; Mon, 4 Feb 2002 04:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSBDJme>; Mon, 4 Feb 2002 04:42:34 -0500
Received: from [66.185.70.129] ([66.185.70.129]:39615 "EHLO rachael.letnet.net")
	by vger.kernel.org with ESMTP id <S288821AbSBDJmT>;
	Mon, 4 Feb 2002 04:42:19 -0500
Message-ID: <3C5E5775.8080709@letu.edu>
Date: Mon, 04 Feb 2002 03:42:13 -0600
From: Chris Dellicker <chrisdellicker@letu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Tulip Driver hangs system in vanilla 2.4.17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2002 09:42:12.0933 (UTC) FILETIME=[39168F50:01C1AD60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently run into a problem with the tulip driver on my laptop.

It loads fine at first, and I can get connected to a network, etc.  When 
I reboot the machine, it hangs when it tries to load the tulip module. 
This only happens with a warm reboot, not a cold boot.  It is quite 
repeatable.  If I power off completely, there is no problem.  If I 
comment the tulip driver out of my startup scripts, there is no problem. 
  If I reboot, it hangs.

This does not happen with the 2.4.5 kernel, only the 2.4.17.  These are 
the only  2 I have tried.

I have found that if I bring down my ethernet interface and unload the 
tulip module before the warm reboot, the system will not lock when it 
comes back up, so I have added the neccessary commands to my shutdown 
scripts.  However, it seems to me like a kernel bug that should probably 
be fixed.

My specific hardware/software config is:

HP Pavillion XH555 laptop with:
1 Ghz Athlon 4
512 MB RAM
ESS sound/modem  (sound using Maestro3 driver)
Accton ethernet   (using tulip driver)

Software:
Slackware 8.0, kernel 2.4.17
using ACPI, tulip, maestro3, ext3, framebuffer, etc.

If there's any more info that would help, please let me know.

-Chris

PS This is the second time I've posted this, so sorry for the 
repetition.  It went seemingly unnoticed the first time, and I have not 
heard anything else about this apparent bug.  Speaking of which, is 
there a place to get a changelog for just certain parts of the kernel? 
(ie a specific driver).

