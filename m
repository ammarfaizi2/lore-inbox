Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVDHV1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDHV1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVDHV1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:27:34 -0400
Received: from fmr17.intel.com ([134.134.136.16]:7836 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261158AbVDHV1Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:27:16 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Fri, 8 Apr 2005 14:25:21 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02F64643@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU8YrbjpHrqd6ATSdSnSEYh/X8+jAAHnUpA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>
X-OriginalArrivalTime: 08 Apr 2005 21:25:22.0295 (UTC) FILETIME=[78AC9070:01C53C81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>
>On Thu, 2005-04-07 at 23:28, Ingo Molnar wrote:
>
>> this one looks really clean.
>>
>> it makes me wonder, what is the current status of fusyn's? Such a
light
>> datastructure would be much more mergeable upstream than the former
>> 100-queues approach.
>
>	Inaky was telling me that 100 queues approach is two years old.
>
>The biggest problem is that fusyn has it's own PI system .. So it's not
>clear if that will work with the RT mutex,. I was thinking the PI stuff
>could be made generic so, fusyn, maybe futex, can use it also .

I concur with Daniel. If we can decide how to deal with that (toss
one out, keep one, merge them, whatever), we could reuse all the user
space glue that is the hardest part to get right.

Current tip of development has some issues with conditional variables
and broadcasts (requeue stuff) that I need to sink my teeth in. Joe
Korty is fixing up a lot of corner cases I wasn't catching, but 
other than that is doing fine.

How long ago since you saw it? I also implemented the futex redirection
stuff we discussed some months ago.

-- Inaky
