Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUHZHvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUHZHvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHZHvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:51:42 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:26376 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S267751AbUHZHvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:51:16 -0400
Subject: Time of process changes to earlier time in process list
From: Norbert van Nobelen <Norbert@edusupport.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1093506726.2331.34.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Aug 2004 09:52:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did two times a 'ps -ef' on a red hat machine. The strange part was
that the time of the following process changed to the past:
First 'ps -ef':
root     14527   902  0 07:17 ?        00:00:00 CROND
root     14529 14527  0 07:17 ?        00:00:00 /bin/sh -c
/root/runtracker.sh >/dev/null
root     14531 14529  0 07:17 ?        00:00:00 /bin/sh -c
/root/runtracker.sh >/dev/null
root     14533 14531  5 07:17 ?        00:00:00 /usr/local/php5/bin/php
/misc/tracker/track.php
root     14536 14423  0 07:17 pts/0    00:00:00 ps -ef

The second process list:
root     14527   902  0 07:16 ?        00:00:00 CROND
root     14529 14527  0 07:16 ?        00:00:00 /bin/sh -c
/root/runtracker.sh >/dev/null
root     14531 14529  0 07:16 ?        00:00:00 /bin/sh -c
/root/runtracker.sh >/dev/null
root     14533 14531  2 07:16 ?        00:00:00 /usr/local/php5/bin/php
/misc/tracker/track.php
root     14537 14423  0 07:17 pts/0    00:00:00 ps -ef

Has anyone observed this behaviour before?

Is it behaviour of the kernel or of the 'ps' program?

Can it cause problems in anyway? (I don't know if the starttime
registration does have any important value in the kernel or not)

Other relevant system info:
/proc/version
Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 07:27:31
EDT 2002

2 cpus:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 996.894
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 996.894
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

Best regards,

Norbert van Nobelen



-- 
Met vriendelijke groet,

Norbert van Nobelen
EduSupport

Postbus 95963
2509CZ Den Haag
T: 070-3280200
M: 06-43036586
F: 070-3280029
E: Norbert@edusupport.nl
I: www.edusupport.nl
B: ABN AMRO
R: 47.38.00.411

