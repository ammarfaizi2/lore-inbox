Return-Path: <linux-kernel-owner+w=401wt.eu-S937696AbWLKWk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937696AbWLKWk4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937697AbWLKWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:40:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:43899 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937696AbWLKWkz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:40:55 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,521,1157353200"; 
   d="scan'208"; a="173270032:sNHT2626375605"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] i386 add idle notifier (take 2)
Date: Mon, 11 Dec 2006 14:40:43 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454FE4AFD@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386 add idle notifier (take 2)
Thread-Index: AccT2TmM8TIqicTsSmKEJ8OCK1CiyQJm5F2w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <eranian@hpl.hp.com>, <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>, <ak@suse.de>
X-OriginalArrivalTime: 11 Dec 2006 22:40:45.0479 (UTC) FILETIME=[6582AB70:01C71D75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephane,

This patch has the same race as in 64 bit patch, that was fixed here
http://www.ussg.iu.edu/hypermail/linux/kernel/0611.3/1264.html

With that race, idle callbacks does not work correctly. Even on a
totally idle system, I can see exit_idle called before enter_idle once
every few seconds. Can you update this patch with similar changes as in
64 bit part in the above patch.

Thanks,
Venki 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Stephane Eranian
>Sent: Wednesday, November 29, 2006 8:41 AM
>To: linux-kernel@vger.kernel.org
>Cc: akpm@osdl.org; ak@suse.de; Stephane Eranian
>Subject: Re: [PATCH] i386 add idle notifier (take 2)
>
>Hello,
>
>[This is the second take due to stray '}' in the patch. Sorry 
>about that]
>
>Here is a patch that adds an idle notifier to the i386 tree.
>The idle notifier functionalities and implementation are
>identical to the x86_64 idle notifier. We use the idle notifier
>in the context of perfmon.
>
>The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
>kernel. It may apply to other kernels but it needs some updates
>to poll_idle() and default_idle() to work correctly.
>
>changelog:
>	- add an idle notifier mechanism to i386 tree
>
>signed-off-by: stephane eranian <eranain@hpl.hp.com>
>
