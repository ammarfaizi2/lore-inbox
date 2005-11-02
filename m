Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVKBCdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVKBCdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKBCdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:33:44 -0500
Received: from fmr18.intel.com ([134.134.136.17]:39880 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932222AbVKBCdn convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 1 Nov 2005 21:33:43 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
Date: Wed, 2 Nov 2005 10:33:19 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1C19A01@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
thread-index: AcW+7lBaYVOB5k1ET+aChvJ2/+Z7ZwgZq0hg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       "Nigel Cunningham" <ncunningham@cyclades.com>,
       "Srivatsa Vaddagiri" <vatsa@in.ibm.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>,
       "Ian Molton" <spyro@f2s.com>
X-OriginalArrivalTime: 02 Nov 2005 02:33:17.0249 (UTC) FILETIME=[C81D1310:01C5DF55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,
>This patch should hopefully fix Nigel's bug.
>
>Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
>and poll idle (previous iterations tested on various other
architectures).
>
>CCed Ian because I am amazed that arm26 ever managed to reschedule
>out of the idle task without this... what am I missing?
>
>Andrew please apply
What's the status of the patch? I didn't see it in base kernel.
We found another bug related with this issue. On UP system, if a CPU
enters 
'mwait_idle', it never leaves it, as the 'mwait_idle' loop will never
end.
Disabling preempt fixes the bug. Should I submit a patch just disabling
preempt in 'mwait_idle' or wait for your patch?

Thanks,
Shaohua
