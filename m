Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUJWCoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUJWCoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUJWCm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 22:42:57 -0400
Received: from fmr05.intel.com ([134.134.136.6]:56971 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269367AbUJWChO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:37:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] HPET reenabling after suspend-resume
Date: Fri, 22 Oct 2004 19:36:57 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60032881C6@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] HPET reenabling after suspend-resume
Thread-Index: AcS4nIyYKKwD2x4SSuSLdH59tVGndQAC7Kmw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <pavel@ucw.cz>
X-OriginalArrivalTime: 23 Oct 2004 02:37:01.0010 (UTC) FILETIME=[2C940B20:01C4B8A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Friday, October 22, 2004 6:07 PM
>To: Pallipadi, Venkatesh
>Cc: akpm@osdl.org; linux-kernel@vger.kernel.org; ak@suse.de; 
>pavel@ucw.cz
>Subject: Re: [PATCH] HPET reenabling after suspend-resume
>
>On Fri, Oct 22, 2004 at 05:26:59PM -0700, Venkatesh Pallipadi wrote:
>> 
>> hpet hardware seems to need a little prodding during resume 
>for it to start 
>> sending the timer interupts again. Attached patch does it 
>for both i386 
>> and x86_64.
>
>Hmm, what HPET hardware? It must have worked on some machines already,
>otherwise suspend/resume would have never worked on many AMD x86-64 
>machines. 
>

That's interesting.... 
I ran into this issue where resume was hanging at 8259_resume 
code as the HPET was not counting. That was on an ICH4 based Pentium-M
box.

I will try it on come ICH5 based hardware and see whether it is really 
Required, for both i386 and x86-64, on a wider range of systems.

Thanks,
venki
