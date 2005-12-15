Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbVLOOBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbVLOOBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVLOOBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:01:04 -0500
Received: from fmr23.intel.com ([143.183.121.15]:41399 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932647AbVLOOBC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:01:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: irq balancing question
Date: Thu, 15 Dec 2005 06:00:53 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006A225B1@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: irq balancing question
Thread-Index: AcYBWAjm9Y4/QBGxRCyf9y7SGu9lsQAJiqdQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Dec 2005 14:00:54.0764 (UTC) FILETIME=[F74582C0:01C6017F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >----- Original Message ----- 
>> >From: "Arjan van de Ven" <arjan@infradead.org>
>> >To: "JaniD++" <djani22@dynamicweb.hu>
>> >> On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
>> >> > Hello, list,
>> >> >
>> >> > I try to tune my system with manually irq assigning, but
>> >this simple not
>> >> > works, and i don't know why. :(
>> >> > I have already read all the documentation in the kernel
>> >tree, and search
>> >in
>> >> > google, but i can not find any valuable reason.
>> >>
>> >>
>> >> which chipset? there is a chipset that is broken wrt irq 
>balancing so
>> >> the kernel refuses to do it there...
>> >
>> >This happens all of my systems, with different hardware.
>> >
>> >In the example is Intel SE7520AF2,  IntelR E7520 Chipset, +2x
>> >Xeon with HT.
>> >
>> >And the other systems is Abit IS7, intel 865, and only one P4
>> >CPU with HT,
>> >but the issue is the same.
>> >
>>
>> Which kernel and which architecture (i386 or x86-64?)
>
>i386, and kernel 2.6.14 - 2.6.15-rc3

Things should work with 2.6.15-rc5. 
There was a bug with this that was fixed recently. The patch here
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=fe655d3a06488c8a188461bca493e9f23fc8c448

>
>(the intel xeon CPU can work x86-64 kernels?)
>

Yes. If your CPUs have EM64T capability, then they can run x86-64
kernels.

Thanks,
Venki
