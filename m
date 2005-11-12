Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVKLDbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKLDbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVKLDbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:31:32 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3490 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751139AbVKLDbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:31:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Date: Fri, 11 Nov 2005 19:30:27 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60064B7E0D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Thread-Index: AcXmDczz6lDzzHljRzygbh9LA/7KuwBK1wCA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexander Clouter" <alex-kernel@digriz.org.uk>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Cc: <davej@redhat.com>, <davej@codemonkey.org.uk>, <blaisorblade@yahoo.it>
X-OriginalArrivalTime: 12 Nov 2005 03:30:29.0834 (UTC) FILETIME=[6E397AA0:01C5E739]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Alexander Clouter
>Sent: Thursday, November 10, 2005 7:11 AM
>To: akpm@osdl.org; linux-kernel@vger.kernel.org
>Cc: davej@redhat.com; davej@codemonkey.org.uk; blaisorblade@yahoo.it
>Subject: [patch 1/1] cpufreq_conservative/ondemand: invert 
>meaning of 'ignore nice'
>
>The use of the 'ignore_nice' sysfs file is confusing to anyone 
>using it.  
>This removes the sysfs file 'ignore_nice' and in its place creates a 
>'ignore_nice_load' entry which defaults to '1'; meaning nice'd 
>processes are 
>not counted towards the 'business' caclulation.
>
>WARNING: this obvious breaks any userland tools that expected 
>'ignore_nice' 
>to exist, to draw attention to this fact it was concluded on 
>the mailing list 
>that the entry should be removed altogether so the userland 
>app breaks and so 
>the author can build simple to detect workaround.  Having said 
>that it seems 
>currently very few tools even make use of this functionality; 
>all I could 
>find was a Gentoo Wiki entry.
>

Wondering whether a 'version' sysfs entry in cpufreq and ondemand 
directory to make sure any change in the interfaces won't break 
the user space tools in future....

Thanks,
Venki
