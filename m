Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUJ0Onf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUJ0Onf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUJ0Onf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:43:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:30939 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262451AbUJ0Onc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:43:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add p4-clockmod driver in x86-64
Date: Wed, 27 Oct 2004 07:43:16 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add p4-clockmod driver in x86-64
Thread-Index: AcS70+S7aN+OwZnRR6CCs/fmzK5cnAAWhFYg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2004 14:43:18.0002 (UTC) FILETIME=[4C245520:01C4BC33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Tuesday, October 26, 2004 8:18 PM
>To: Pallipadi, Venkatesh
>Cc: akpm@osdl.org; ak@suse.de; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
>
>On Tue, Oct 26, 2004 at 02:28:26PM -0700, Venkatesh Pallipadi wrote:
>> 
>> Add links for p4-clockmod driver in x86-64 cpufreq. 
>
>Does this really make sense? I thought all shipping EM64T capable CPUs
>supported DBS?  Why would you want clock modulation when you have DBS?
>
>My own experience is that the clockmod driver is not very usable,
>it leads to extensive delays on a graphical desktop.
>

Yes. Clock modulation is not as useful compared to enhanced speedstep.
But, 
I feel, it should be OK to have the driver, though it is not really
useful 
in common case. It may be useful in some exceptional cases. 

The particular case where someone wanted to use p4-clockmod was: they
wanted to run the CPU as slow as possible. Enhanced speedstep allows few

(2-3) possible freqs on this CPU. But, p4-clockmod allows as low as
12.5% 
actual freq.

So, I think, it is good to have this module for the users who really
want 
to use it. But I don't think any userspace or kernel governor should use

this driver by default, without user knowledge. That can cause extensive

delays and slow response times.

Thanks,
Venki


