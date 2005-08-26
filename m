Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVHZSDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVHZSDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVHZSDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:03:54 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:12475 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S965158AbVHZSDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:03:52 -0400
Message-ID: <430F5901.2070606@inov.pt>
Date: Fri, 26 Aug 2005 19:01:37 +0100
From: Jose Miguel Goncalves <jose.goncalves@inov.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: miura@da-cha.org
Subject: Problem with cpufreq on Geode GX1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to use cpufreq on my Geode GX1 board with linux-2.6.12.5, but,
while everything seems OK, i.e., I can change from performance to powersave
governor and back and /proc/cpuinfo reports me frequency changes, I can
get no effective frequency/CPU power change because I check it with
the Whetstone benchmark and it allways give me the same value (~100 MWIPS).
Any ideas from were could be the problem?

Some additional info follows:

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

performance

$ cat /proc/cpuinfo

processor	: 0
vendor_id	: CyrixInstead
cpu family	: 5
model		: 9
model name	: Geode(TM) Integrated Processor by National Semi
stepping	: 2
cpu MHz		: 300.672
cache size	: 16 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 591.87

$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

$ cat /proc/cpuinfo

processor	: 0
vendor_id	: CyrixInstead
cpu family	: 5
model		: 9
model name	: Geode(TM) Integrated Processor by National Semi
stepping	: 2
cpu MHz		: 37.095
cache size	: 16 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 73.02

Best regards,
Jose Goncalves
