Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWGZSe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWGZSe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWGZSe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:34:26 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:54070 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161028AbWGZSeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:34:25 -0400
X-BigFish: V
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Wed, 26 Jul 2006 13:34:14 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218F09@SAUSEXMB1.amd.com>
In-Reply-To: <200607261854.20670.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: Acaw1OhcS/s6zL/lSzi2NH1XHGXSmgADAPiA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: "Gulam, Nagib" <nagib.gulam@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 26 Jul 2006 18:34:14.0906 (UTC)
 FILETIME=[18A2D5A0:01C6B0E2]
X-WSS-ID: 68D96A2D1NW363750-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > AMD Opteron(tm) Processor 838 stepping 01 CPU 3: Syncing 
> TSC to CPU 0.
> > CPU 3: synchronized TSC with CPU 0 (last diff -109 cycles, 
> maxerr 1024
> 
> Hmm, indeed  - i would have expected higher max errors too.
> It should have worked in theory. No explanation currently.

THat's unfortunate.
 
> > cycles)
> > powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6
> > powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8
> > powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
> > powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
> > 
> > Is there a better test we can be using?
> 
> I don't know of any. Ok I guess it would be possible to write 
> something in user space, but it would likely look similar to 
> the algorithm the kernel uses.

I ran the following simple test on the 4P system with TSC
gtod for a week:
while true; do date; sleep 3600; done
the first entry went in at July 13 15:39:48, the last entry
at  July 25 15:39:50.  A drift of 2 seconds over 12 days is 
within specification, I believe.

In contrast, the same machine running with TSC and standard
PN! sees massive drift, upwards of an hour, within an hour.

If the TSCnow! patch reduces measured drift down to a second 
a week, would you consider that acceptable?

-Mark Langsdorf
AMD, Inc.




