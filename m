Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbUJ0QrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUJ0QrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbUJ0Qot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:44:49 -0400
Received: from fmr01.intel.com ([192.55.52.18]:30905 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262501AbUJ0QkD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:40:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add p4-clockmod driver in x86-64
Date: Wed, 27 Oct 2004 09:39:45 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600333A7B0@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add p4-clockmod driver in x86-64
Thread-Index: AcS8NY4q/9wC6NrJSEukU+lGlVidmQADM7vw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Cc: "Andi Kleen" <ak@suse.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2004 16:39:47.0123 (UTC) FILETIME=[91FB9030:01C4BC43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Paulo Marques [mailto:pmarques@grupopie.com] 
>Sent: Wednesday, October 27, 2004 7:59 AM
>To: Pallipadi, Venkatesh
>Cc: Andi Kleen; akpm@osdl.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
>
>Pallipadi, Venkatesh wrote:
>>>....
>> Yes. Clock modulation is not as useful compared to enhanced 
>speedstep.
>> But, 
>> I feel, it should be OK to have the driver, though it is not really
>> useful 
>> in common case. It may be useful in some exceptional cases. 
>
>I think I have one of such cases.
>
>I am one of the members of the robotic soccer team from the University 
>of Oporto, and a couple of months ago we were looking for new 
>motherboards for our robots, because we are starting to need new 
>hardware (on-board lan, usb2.0, etc.).
>
>We really don't need excepcional performance, but we really, 
>really need 
>low power consumption, so lowering the clock on a standard mainboard 
>seemed to be the best cost/performance scenario.
>
>Could this driver be used to keep a standard p4 processor at say 25% 
>clock speed at all times?
>

Yes and No.

No because, AFAIK p4-clockmod doesn't give a lot of direct power
savings. 
You can still get some indirect power savings from cooling perspective.
If the processor supports both Enhanced Speedstep Technology (EST) 
and p4-clockmod, EST will save more power and is preferred over
p4-clockmod.
Clockmod uses duty-cycle approach to modulate the freq. EST changes CPU 
core voltage and freq.

Yes because, with p4-clockmod you can change the freq between 8 possible
values
(Processor freq) * n/8, where n=1, 2, ... 8

Thanks,
Venki
