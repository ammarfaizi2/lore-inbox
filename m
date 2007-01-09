Return-Path: <linux-kernel-owner+w=401wt.eu-S932458AbXAIWQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXAIWQZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbXAIWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:16:25 -0500
Received: from wapgw.hccnet.nl ([62.251.0.19]:37894 "EHLO wapgw.hccnet.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbXAIWQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:16:24 -0500
X-Greylist: delayed 5394 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 17:16:24 EST
Message-ID: <45A3FF3E.7060109@hccnet.nl>
Date: Tue, 09 Jan 2007 21:46:54 +0100
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oprofile broken on 2.6.19
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to use oprofile on 2.6.19, it does not seem to work:

[gert@apollo tmp]$ sudo opcontrol --no-vmlinux
[gert@apollo tmp]$  sudo opcontrol --start
/usr/bin/opcontrol: line 911: /dev/oprofile/0/enabled: No such file or directory/usr/bin/opcontrol: line 911: 
/dev/oprofile/0/event: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/count: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/kernel: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/user: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/unit_mask: No such file or directory
Using 2.6+ OProfile kernel interface.
Using log file /var/lib/oprofile/oprofiled.log
Daemon started.
Profiler running.
[gert@apollo tmp]$ ls /dev/oprofile/
1  backtrace_depth  buffer_watershed  dump          stats
2  buffer           cpu_buffer_size   enable
3  buffer_size      cpu_type          pointer_size
[gert@apollo tmp]$ cat /var/lib/oprofile/oprofiled.log
oprofiled started Tue Jan  9 21:41:02 2007
kernel pointer size: 8
[gert@apollo tmp]$ uname -a
Linux apollo 2.6.19 #1 PREEMPT Thu Nov 30 18:52:13 CET 2006 x86_64 x86_64 x86_64 GNU/Linux
[gert@apollo tmp]$


    Gert

