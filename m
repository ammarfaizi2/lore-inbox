Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWDYORb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWDYORb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDYORb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:17:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:48263 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932230AbWDYORa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:17:30 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="28304750:sNHT62615539"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] [PATCH] Make ACPI button driver an input device
Date: Tue, 25 Apr 2006 22:17:23 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206CD@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH] Make ACPI button driver an input device
Thread-Index: AcZlPhGEolz0htwGRxiyCILk9D3UmADLEJUw
From: "Yu, Luming" <luming.yu@intel.com>
To: <dtor_core@ameritech.net>
Cc: "Alexey Starikovskiy" <alexey_y_starikovskiy@linux.intel.com>,
       "Xavier Bestel" <xavier.bestel@free.fr>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2006 14:17:24.0685 (UTC) FILETIME=[F96CB7D0:01C66872]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> > There are keyboards with power/sleep buttons. It makes
>> >sense they have
>> >> > the same behavior than ACPI buttons.
>> >> Agree, make them behave like ACPI buttons -- remove them
>> >from input stream, as they do not belong there...
>> >
>> >What if there is no ACPI? What if I want to remap the button to do
>> >something else? Input layer is the proper place for them.
>>
>> If you define input layer as a universe place to all manual input
>> activity,
>
>Yes. If something is related to input it should be integrated 
>into input layer.

Yes, it sounds reasonable. Then, at least, the user space Apps can
rely on a single interface, and don't need to know the implementation  
details for the common input event. That will save a lot of support
effort. 

>
>> then I agree to port some type of ACPI event into
>> input layer.  But it shouldn't be a fake keyboard scancode,
>> My suggestion is to have a separate input event type,e.g. EV_ACPI
>> for acpi event layer.
>>
>
>The point is that it is not a fake scancode. There are keyboards that
>have these keys that don't have anything to do with ACPI. That's why
>they belong to input layer. The same goes for lid switch - we have
>EV_SW that is used by some PDAs.

ok.

>
>Note that I am not saying that other ACPI events, like battery status
>or device insertion/removal, should be propagated through input layer.
>But things that exist even without ACPI should not be ACPI-specific.
>

I'm NOT sure if it is reasonable to propagate other ACPI events 
through input layer.  But from my understanding, Laptop with ACPI
features 
should be the super class of PDA. It would be nice to have input layer
handle all ACPI events. Then, we can enjoy the advantage of a single 
input interface for user Apps.

--Luming 
