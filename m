Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268853AbTCCXKn>; Mon, 3 Mar 2003 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbTCCXKn>; Mon, 3 Mar 2003 18:10:43 -0500
Received: from mail.gemsoft.net ([195.10.254.5]:9740 "EHLO mail.gemsoft.net")
	by vger.kernel.org with ESMTP id <S268853AbTCCXKm>;
	Mon, 3 Mar 2003 18:10:42 -0500
Message-ID: <3E63E348.10604@walrond.org>
Date: Mon, 03 Mar 2003 23:20:40 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CONFIG_NR_CPUS (or something related) broken in 2.5 ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the number of cpus to 4 causes only 2 to be displayed in 
/proc/cpuinfo

(On a dual P4 Xeon (Hyperthreaded) machine which normally shows 4 CPUs)

I'm using...

*
* ACPI Support
*
ACPI Support (ACPI) [Y/n/?] y
   CPU Enumeration Only (ACPI_HT_ONLY) [Y/n/?] y

...to detect the HT Xeons.

Trying with CONFIG_NR_CPUS=5........Same
Trying with CONFIG_NR_CPUS=6........Same
Trying with CONFIG_NR_CPUS=7........3 Processors - Weird!
Trying with CONFIG_NR_CPUS=8........4 Processors - Hoorah!

Strange, or am I missing something?

Andrew Walrond

[Me: Off to try CONFIG_NR_CPUS=32  :)]

