Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267887AbUGWSy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267887AbUGWSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267888AbUGWSy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:54:28 -0400
Received: from ms01.sssup.it ([193.205.80.99]:34971 "EHLO sssup.it")
	by vger.kernel.org with ESMTP id S267887AbUGWSy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:54:26 -0400
Message-ID: <41015EEF.3070602@sssup.it>
Date: Fri, 23 Jul 2004 20:54:39 +0200
From: Riccardo Vestrini <riccardov@sssup.it>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is it really better speedstep-ich vs. p4-clockmod cpufreq driver?
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it seems that speedstep-ich and acpi cpufreq driver have only two usable
clock frequencies, while p4-clockmod has eight
my cpu is: Intel Mobile Intel(R) Pentium(R) 4   CPU 3.06GHz stepping 09



last 2.6 kernel I tried (2.6.7) has introduced a warning while loading
p4-clockmod module:

p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
p4-clockmod: Warning: Pentium 4-M detected. The speedstep-ich or acpi
cpufreq modules offer voltage scaling in addition of frequency scaling.
You should use either one instead of p4-clockmod, if possible.

so I immediatly switched to speedstep-ich discovering that:
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
3066590 1599960

while with p4-clockmod I have:
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
383323 766647 1149971 1533295 1916618 2299942 2683266 3066590

using acpi driver gives a message:
cpufreq: CPU0 - ACPI performance management activated.
cpufreq:  P0: 3059 MHz, 24000 mW, 100 uS
cpufreq: *P1: 1596 MHz, 12000 mW, 100 uS
but:
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
3059000 1596000


i do not know what driver is supposed to be better and why speedstep-ich 
driver has only two frequencies

thank you

-- 

                                Riccardo Vestrini
                               <riccardov@sssup.it>


