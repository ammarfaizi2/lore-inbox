Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUCNIFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 03:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUCNIFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 03:05:11 -0500
Received: from fmr06.intel.com ([134.134.136.7]:37276 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261528AbUCNIFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 03:05:01 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.4-mm1
Date: Sun, 14 Mar 2004 00:04:51 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEBA2C@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.4-mm1
Thread-Index: AcQI/Tnb3XGrDsdsTJ+jC5YS+eDlbAAm1uhQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "SUBODH SHRIVASTAVA" <subodh@btopenworld.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2004 08:04:52.0196 (UTC) FILETIME=[07669240:01C4099B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked and tried several things, and I think CONFIG_PCI_USE_VECTOR is
a red herring. 2.6.4-mm1 did boot with CONFIG_PCI_USE_VECTOR = Y or N as
long as kernel preemption is disabled. It did not boot regardless of
CONFIG_PCI_USE_VECTOR if kernel preemption is enabled. I see the
complaints
  bad: scheduling while atomic!
at various spots.

2.6.4 does not have this problem; kernel preemption seems to work fine.
I encourage people to check kernel preemption in 2.6.4-mm1.

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of SUBODH SHRIVASTAVA
>Sent: Saturday, March 13, 2004 5:13 AM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: 2.6.4-mm1
>
> --- Andrew Morton <akpm@osdl.org> wrote: > Subodh
>Shrivastava <subodh@btopenworld.com> wrote:
>> >
>> > I am able to boot vanilla kernel without the
>> following option enabled
>> >
>> > CONFIG_PCI_USE_VECTOR
>> >
>> > If i don't enable the above mentioned option
>> 2.6.4-mm1 won't boot on my
>>
>>        ^^^^^ "do", I assume?
>
>Let me try to put it correct again.
>
>2.6.4 boots fine with the following option set as
>CONFIG_PCI_USE_VECTOR=N
>
>2.6.4-mm1 will not boot with the following option set
>as.
>CONFIG_PCI_USE_VECTOR=N
>2.6.4-mm1 will boot with the following option set as
>CONFIG_PCI_USE_VECTOR=Y
>
>>
>> > Laptop
>>
>> Is this unique to 2.6.4-mm1 or does 2.6.4 do the
>> same thing?
>Yes its unique to 2.6.4-mm1.
>
>Subodh
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
