Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJYTAn>; Fri, 25 Oct 2002 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJYTAm>; Fri, 25 Oct 2002 15:00:42 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:46309 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261530AbSJYTAf>; Fri, 25 Oct 2002 15:00:35 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000EA17100@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, chrisl@vmware.com,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: How to get number of physical CPU in linux from user space?
Date: Fri, 25 Oct 2002 12:05:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant /proc/cpuinfo

Thanks,
Jun

-----Original Message-----
From: Nakajima, Jun 
Sent: Friday, October 25, 2002 11:53 AM
To: 'chrisl@vmware.com'; Martin J. Bligh
Cc: linux-kernel@vger.kernel.org
Subject: RE: How to get number of physical CPU in linux from user space?


Recent distributions or the AC tree has additional fields in /proc/cpu,
which tell
- physical package id
- number of threads 
for each CPU.

Using this info, you should be able to detect it. The problem is that they
are not using the same keywords. I'm asking them to make those fields
consistent.

Thanks,
Jun

-----Original Message-----
From: chrisl@vmware.com [mailto:chrisl@vmware.com]
Sent: Friday, October 25, 2002 11:20 AM
To: Martin J. Bligh
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?



On Fri, Oct 25, 2002 at 01:27:00AM -0700, Martin J. Bligh wrote:
> Define "physical CPU number" ;-) If you want to deteact which

I mean the number of cpu chip you can count on the mother board.

> ones are paired up, I believe that if all but the last bit
> of the apicid is the same, they're siblings. You might have to
> dig the apicid out of the bootlog if the cpuinfo stuff doesn't
> tell you.

And you are right. Those apicid, after mask out the siblings,
are put in phys_cpu_id[] array in kernel.

I think about look at bootlog too, but that is not a reliable
way because bootlog might already been flush out after some
time.

Cheers

Chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
