Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQLJNvA>; Sun, 10 Dec 2000 08:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131098AbQLJNuv>; Sun, 10 Dec 2000 08:50:51 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:22767 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131016AbQLJNug>;
	Sun, 10 Dec 2000 08:50:36 -0500
From: thunder7@xs4all.nl
Date: Sun, 10 Dec 2000 14:18:30 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre25: VM: do_try_to_free_pages failed for
Message-ID: <20001210141830.A692@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for almost everything:

Dec 10 13:33:47 middle kernel: VM: do_try_to_free_pages failed for kswapd...
Dec 10 13:33:50 middle kernel: VM: do_try_to_free_pages failed for gdb...
Dec 10 13:33:50 middle last message repeated 9 times
Dec 10 13:33:57 middle kernel: VM: do_try_to_free_pages failed for kswapd...
Dec 10 13:33:59 middle kernel: VM: do_try_to_free_pages failed for gdb...
Dec 10 13:34:04 middle last message repeated 13 times
Dec 10 13:34:05 middle kernel: VM: do_try_to_free_pages failed for init...
Dec 10 13:34:06 middle last message repeated 12 times
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for gdb...
Dec 10 13:34:07 middle last message repeated 12 times
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for vmware-nmbd...
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for cron...
Dec 10 13:34:07 middle last message repeated 2 times
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for slrnpull...
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for klogd...
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for klogd...
Dec 10 13:34:07 middle kernel: VM: do_try_to_free_pages failed for cron...
Dec 10 13:34:08 middle last message repeated 5 times
Dec 10 13:34:09 middle kernel: VM: do_try_to_free_pages failed for gdb...
Dec 10 13:34:22 middle last message repeated 10 times
Dec 10 13:34:22 middle kernel: VM: do_try_to_free_pages failed for slrnpull...
Dec 10 13:34:24 middle last message repeated 2 times
<tried to log in over the network, didn't work, pressed C-A-D and
watched fsck mull over 60+ Gb>

Now it was true I forgot to re-instate the mem=512M line for loadlin,
but even so:
/usr/bin/free:
             total       used       free     shared    buffers     cached
Mem:         63740      56064       7676      22160      23032      17396
-/+ buffers/cache:      15636      48104
Swap:       530104        304     529800

should be enough to run slrnpull and expire a newsspool with about
2,000,000 files, right?

Most messages I was able to dig up about this mentioned 2.2.17 and
suggested upgrading to 2.2.18pre. I didn't think there is anything
changed between 2.2.18pre25 and 2.2.18pre26(2.2.18 to be) in VM
handling, so the problem still seems to persist. What are the
suggestions? Moving to 2.4 is not possible, since the isdn compression
module isdn_lzscomp.o won't work in 2.4.

Greetings,
Jurriaan
-- 
(A)bort, (R)etry, (I)gnore, (V)alium?
GNU/Linux 2.2.18pre25 SMP 2x1117 bogomips load av: 1.05 1.91 1.11
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
