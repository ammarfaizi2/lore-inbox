Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUKQW2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUKQW2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUKQWZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:25:59 -0500
Received: from fmr12.intel.com ([134.134.136.15]:55721 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262574AbUKQWU4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:20:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: "power" file disappeared after powering down slot in 2.6.9 & 2.6.10-rc1
Date: Wed, 17 Nov 2004 14:20:27 -0800
Message-ID: <468F3FDA28AA87429AD807992E22D07E0354279E@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "power" file disappeared after powering down slot in 2.6.9 & 2.6.10-rc1
Thread-Index: AcTM86RGMD9DwAkrS/uEpq8LL+k7jA==
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: <linux-kernel@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>
Cc: "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 17 Nov 2004 22:20:29.0240 (UTC) FILETIME=[A51BD380:01C4CCF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.9 and 2.6.10-rc1, I encountered the problem that doing 
"echo 0 > /sys/bus/pci/slots/X/power" or "using attention button" 
to power down slot caused the "power" file under /sys/bus/pci/slots/X/
to disappear. Actually, two other files under the same directory 
disappeared also. However, this problem was resolved in 2.6.10-rc2.

Looking at the changelog for 2.6.10-rc2, I saw there were a lot of 
changes related to sysfs.  Does anyone know what changes may have 
fixed this problem? Or, what might be the cause of the problem that 
I saw in 2.6.9 & 2.6.10-rc1?

Tracing back, I found that "disappearing of power file after powering 
down the slot" started to appear in 2.6.9-rc3 and lasted till
2.6.10-rc1.  
Before this kernel, it worked fine (in 2.6.9-rc2-mm4).  I found this 
problem when I used shpch & pciehp drivers and I would like to see if
anyone see this problem while using other hot-plug drivers.

Thanks,
Dely 

