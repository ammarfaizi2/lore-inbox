Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUELP2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUELP2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUELP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:28:36 -0400
Received: from firecat.admindu.de ([213.178.172.5]:28037 "EHLO mail.admindu.de")
	by vger.kernel.org with ESMTP id S265109AbUELP2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:28:05 -0400
Message-ID: <40A242A6.4020002@kurtenba.ch>
Date: Wed, 12 May 2004 17:28:38 +0200
From: clemens kurtenbach <moqua@kurtenba.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 MultiZilla/1.6.3.0d
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpufreq and p4 prescott
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have problems scaling down my p4 prescott 2.8 GHz.
In the /sys -tree all seems to be ok:

[ck@holodeck:cpufreq] pwd
/sys/devices/system/cpu/cpu0/cpufreq

[ck@holodeck:cpufreq] ls -1
cpuinfo_max_freq
cpuinfo_min_freq
scaling_available_frequencies
scaling_available_governors
scaling_driver
scaling_governor
scaling_max_freq
scaling_min_freq
scaling_setspeed

[ck@holodeck:cpufreq] cat *
2800000
350000
350000 700000 1050000 1400000 1750000 2100000 2450000 2800000
powersave userspace performance
p4-clockmod
userspace
2800000
350000
350000

[ck@holodeck:cpufreq] cat /proc/cpuinfo | grep Mhz
cpu MHz         : 2807.131
cpu MHz         : 2807.131

As you can see tools like cpudyn or powernowd successfully
change the entry in scaling_setspeed (also for cpu1),
but the real cpu clock stays at 2.8GHz ?

The cpudyn doc sais there's support for 'Intel Pentium 4, Intel Xeon'
CPU's, but is there support for p4 prescott ?

Has annyone here successfully scaled down a prescott ?

regards,
clee
-- 
moqua [at] gmx.net
moqua [at] kurtenba.ch
