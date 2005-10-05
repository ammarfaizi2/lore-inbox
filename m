Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVJEUiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVJEUiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVJEUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:38:11 -0400
Received: from fmr15.intel.com ([192.55.52.69]:27616 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750799AbVJEUiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:38:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 5/7] HPET-RTC: disable interrupt when no longer needed
Date: Wed, 5 Oct 2005 13:37:46 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005EB230A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/7] HPET-RTC: disable interrupt when no longer needed
Thread-Index: AcXEv1jmO9fzyUegThuqmuc/dU4bCQFLQJQg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Clemens Ladisch" <clemens@ladisch.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Bob Picco" <bob.picco@hp.com>
X-OriginalArrivalTime: 05 Oct 2005 20:37:47.0431 (UTC) FILETIME=[A565E370:01C5C9EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: aezr4@studcom.urz.uni-halle.de 
>[mailto:aezr4@studcom.urz.uni-halle.de] On Behalf Of Clemens Ladisch
>Sent: Wednesday, September 28, 2005 11:30 PM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; Bob Picco
>Subject: Re: [PATCH 5/7] HPET-RTC: disable interrupt when no 
>longer needed
>
>Venkatesh Pallipadi wrote:
>> On Wed, Sep 28, 2005 at 09:12:26AM +0200, Clemens Ladisch wrote:
>> > When the emulated RTC interrupt is no longer needed, we 
>better disable
>> > it; otherwise, we get a spurious interrupt whenever the timer has
>> > rolled over and reaches the same comparator value.
>> >
>> > Having a superfluous interrupt every five minutes doesn't 
>hurt much,
>> > but it's bad style anyway.  ;-)
>>
>> Do you really see the interrupt every five minutes once RTC 
>is disabled.
>
>Yes; at least on my Intel chipset.  ;-)
>
>> I had assumed while in one-shot interrupt mode, HPET would 
>automatically unarm
>> after generating the interrupt, so that we won't get 
>interrupts any more.
>
>The spec never mentions this.  What it mentions is that it was
>designed so that it can be implemented in as few gates as possible.
>

Verified in the latest version of the SPEC. It indeed says that
one shot timer can happen more than once when the 32 bit counter 
wraps around. So, this patch is also required. Thanks for all the fixes.

Andrew, Please pick this one as well.

Thanks,
venki
