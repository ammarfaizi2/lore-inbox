Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbTFNPMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbTFNPMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:12:41 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:40411 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S265675AbTFNPMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:12:40 -0400
From: Frank Dekervel <kervel-lkml@drie.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: redhat 2.4.18-14 kernel weird behaviour
Date: Sat, 14 Jun 2003 17:26:23 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306141726.23213.kervel-lkml@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i see the following on a redhat8 2.4.18-14 machine: a 'snmpdm' process (part 
of ciagent) gets stuck, using 100% cpu (100% 'system' usage in top).
after that, the machine becomes unusable: impossible to ssh to the machine, 
daemons like mysql and oracle become non-functional , ...
thats the first weird part, but there is more:
in one case a hard kill (killall -9 snmpdm) did not have immediate effect: the 
process only got killed several hours after the hard kill (i don't know how 
long, when the kill failed my session froze, and i gave up. next morning 
everything was normal again, and snmpdm was killed). in another case the hard 
kill worked, and after killing snmpdm the system became normal again 
immediately (frozen ssh sessions came to life again, ...)

i managed to kill the process via a ssh session that did not freeze for some 
reason. when the system returned to normal, i could see that the system load 
was very high, so the 'frozen' processes were probably just stuck in D state 
(the only process taking CPU was snmpdm). disk starvation or something ?

Did someone experience the same problems (using rh8 kernel) ? i searched the 
redhat bugzilla database and i checked the kernel errata, but i could not 
find anything relevant... And someone has a clue on how to find the cause of 
this problem ? (its not easy to reproduce, altough it happent 3 times in 3 
weeks time or so)

thanks in advance,
greetings,
frank
