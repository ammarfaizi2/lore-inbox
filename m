Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUFBNms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUFBNms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFBNmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:42:47 -0400
Received: from cptpc8.univ-mrs.fr ([139.124.7.122]:30983 "EHLO
	cptpc8.univ-mrs.fr") by vger.kernel.org with ESMTP id S262874AbUFBNm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:42:28 -0400
Message-ID: <40BDF575.9090901@cern.ch>
Date: Wed, 02 Jun 2004 15:42:45 +0000
From: Christian Hoelbling <christian.holbling@cern.ch>
Reply-To: Christian.Hoelbling@cpt.univ-mrs.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: speedstep-ich on Mobile P4 HT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  i tried to use the sppedstep-ich module on my P4M-HT (stepping 9 533 
MHz FSB). the cpuinfo_x86 reports an ebx=0x08. after adding this to the 
allowed cases in speedstep_detect_processor in speedstep-lib.c, the 
module loads fine and does voltage scaling correctly.
 however, after a random amont of time, the system freezes solid. if i 
enable the debug option, the last syslog entries are:

Jun  1 23:20:18 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0x17310b17 0x0
Jun  1 23:20:18 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 23
Jun  1 23:20:18 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0xc310b17 0x0
Jun  1 23:20:18 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 12
Jun  1 23:20:38 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0xc310b17 0x0
Jun  1 23:20:38 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 12
Jun  1 23:20:38 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0x17310b17 0x0
Jun  1 23:20:38 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 23
Jun  1 23:20:48 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0x17310b17 0x0
Jun  1 23:20:48 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 23
Jun  1 23:20:48 cookie speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 
0xc310b17 0x0
Jun  1 23:20:48 cookie speedstep-lib: P4 - FSB 133330 kHz; Multiplier 12
followed by hundreds of NULL-characters.

i tested it on kernels 2.6.5, 2.6.6 and 2.6.7-rc1 with SMP and preempt.

i am trying to fix this problem, but i am very inexperienced in kernel 
programming and would appreciate any hint/help.

chris

ps: sorry if this post is inappropriate, but i could not find any hint 
about this problem on the net.
