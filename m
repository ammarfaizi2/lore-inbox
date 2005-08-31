Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVHaXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVHaXSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHaXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:18:36 -0400
Received: from fmr17.intel.com ([134.134.136.16]:41357 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932390AbVHaXSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:18:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Wed, 31 Aug 2005 16:17:43 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B02E8@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWugL6C+ryRLGL1SpiL0A3ZgdCIcgAAS7Vw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: <joe.korty@ccur.com>, <akpm@osdl.org>, <george@mvista.com>,
       <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Aug 2005 23:17:47.0379 (UTC) FILETIME=[32F47430:01C5AE82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Christopher Friesen [mailto:cfriesen@nortel.com]
>Perez-Gonzalez, Inaky wrote:
>
>>>I can get the first sleep.  Suppose I oversleep by X nanoseconds.  I
>>>wake, and get an opaque timeout back.  How do I ask for the new wake
>>>time to be "endtime + INTERVAL"?
>>
>>
>> endtime.ts += INTERVAL
>> [we all know opaque is relative too]
>
>Heh. Okay, then what are the rules about what I'm allowed to do with
>endtime?  Joe mentioned there was a bit in there somewhere to denote
>absolute time.

Well, it doesn't really matter. The bit in endtime.clock_id (highest,
AFAIR) says if it is absolute or not, but because adding a relative
value to a value maintains its condition (absolute or relative), it
is not a concern. Just add it.

Unless I am missing something really basic, of course.

>> Or better, use itimers :)
>
>I as actually thinking in terms of implementing itimers on top of your
>new API.

Heh, got me.

-- Inaky
