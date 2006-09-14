Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWINOw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWINOw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWINOw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:52:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16316 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750721AbWINOwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:52:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=lGVSQ6Sj+gtpar+V0i4jiWDQaWDaKkRSXe2lgwmbHvowPWxTxj+km1PI/bHoysQvvxFBscppzd47LuqtsjHOiUfux1NXB/ENdFLZJj8ZiMVGPOLa6D/6MJNQ15MswzG6Nml4pQ81b47drApu+/3//DE+h+Pal6cNORVquPgnxqI=
Message-ID: <45096CB1.5030104@gmail.com>
Date: Thu, 14 Sep 2006 18:52:33 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] CPUFreq PowerOP integration, Issues/TODO 3/3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- speedstep-centrino.c and speedstep-centrino-pm_core.c are no longer relevant
to CPUFreq - need to be moved out of cpufreq folder
- drivers/acpi/processor_perflib.c: needs cleanup. Now it is used by PM Core
but is compiled under CONFIG_CPU_FREQ and contains CPUFreq dependent code
- cpufreq.c code needs fixing to handle creation of operating points at
arbitrary moment ( to function properly on empty points list). For the time
being it is assumed that initialization order is: acpi, pm core, powerop, points
registration, cpufreq core
- cpufreq statistics is broken
- hotplug/sysdev_driver needs investigation
- pm core needs hotplug support
- example of dependent operating point registration module
- is any functionality affected by removing flags export from legacy cpufreq
driver?
- suspend/resume

