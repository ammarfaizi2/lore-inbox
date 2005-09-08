Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVIHIzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVIHIzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIHIzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:55:32 -0400
Received: from fmr16.intel.com ([192.55.52.70]:7102 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932412AbVIHIzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:55:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 04:55:13 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F06@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] ACPI for 2.6.14
Thread-Index: AcW0Tn5FbjOfW0IRRRGLEPAkV3FkdQAAFkGw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Sep 2005 08:55:16.0430 (UTC) FILETIME=[084A4EE0:01C5B453]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Brown, Len" <len.brown@intel.com> wrote:
>>
>> I saw lots of transient battery issues from 2.6.13-rc3
>>  until 2.6.13-rc6, but the ones I followed went away
>>  as of 2.6.13 final.  Do you have your eye on others
>>  besides 4980?
>
>Not specifically, but then ACPI bugs are the one sort which I 
>don't track. 
>a) because there are so many and b) because the ACPI team use bugzilla
>well.

In the last 5 weeks we've reduced our unresolved bug count
to 160 from 196 -- even as 50 new sightings rolled in:

 9/8/05:	739	Resolved	160	Unresolved	899	Total
 8/31/05:	733	Resolved	161	Unresolved	894	Total
 8/24/05:	721	Resolved	166	Unresolved	887	Total
 8/17/05:	694	Resolved	181	Unresolved	875	Total
 8/10/05:	666	Resolved	194	Unresolved	860	Total
 8/3/05:	653	Resolved	196	Unresolved	849	Total

>Sticking "battery" into the bugzilla Summary field turns up a few. 
><vague>There seem to have been four or five reports in recent weeks.

<specific:->
We have a bugzilla category for battery issues.
There are 12 open, 4 of them resolved -- 3 of those
fixes are included in the proposed patch:
http://bugzilla.kernel.org/show_bug.cgi?id=4892
through the ec_burst=1 fix is still optional:
http://bugzilla.kernel.org/show_bug.cgi?id=3851
http://bugzilla.kernel.org/show_bug.cgi?id=3974

I think it makes sense to proceed to get broader
testing on the latest code.  We're not getting
new failure reports from -mm.

Indeed, I'd like to try enabling the new ec_burst=1
by default in -mm.  It is not perfect, but it works
for me, so it should do much better than the 2.6.13-rc3 attempt.

We'll keep ec_burst=0 as the default in Linus' tree
for now.  The systems that require ec_burst=1 will
have to supply it manually for now, which is better
than not having it all per 2.6.12.

thanks,
-Len
