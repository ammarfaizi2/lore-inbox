Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTK0Lkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTK0Lkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:40:35 -0500
Received: from ftp.symdata.com ([207.44.192.51]:62161 "HELO dev.symdata.com")
	by vger.kernel.org with SMTP id S264486AbTK0LkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:40:24 -0500
From: Simon <simon@highlyillogical.org>
Organization: highlyillogical.org
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Date: Thu, 27 Nov 2003 11:39:07 +0000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311271139.07260.simon@highlyillogical.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry... I posted this to the cpufreq list yesterday but I didn't get a 
response. Apologies for crossposting.

I've just upgraded to 2.6.0-test10 and am trying to use the new cpufreq stuff 
in there. I had everything working perfectly with 2.4.21-ac2, and the old 
/proc/cpufreq interface.

I have a P4 2ghz (in a thinkpad), but it's not running at over about 1.2ghz 
now. If I `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq` it 
tells me: "1198976". It should go faster than that. Similarly, 
scaling_available_frequencies says "149872 299744 449616 599488 749360 899232 
1049104 1198976"

Enabling the old interface in the kernel and doing a `echo -n 
0%0%100%performance > /proc/cpufreq` doesn't change things either.

Here is my /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping        : 7
cpu MHz         : 1198.976
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 2359.29

Any ideas?

Cheers,
Simon


