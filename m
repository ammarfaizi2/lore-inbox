Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbUKIXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbUKIXto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUKIXtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:49:15 -0500
Received: from fmr01.intel.com ([192.55.52.18]:49805 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261791AbUKIXst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:48:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: /sys/devices/system/timer registered twice
Date: Tue, 9 Nov 2004 15:48:33 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60034D6FB9@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /sys/devices/system/timer registered twice
Thread-Index: AcTGthsW7qtCDrHbQvay1OWhHZ+27wAACWkA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <dtor_core@ameritech.net>, "Kay Sievers" <kay.sievers@vrfy.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2004 23:48:34.0824 (UTC) FILETIME=[A041F080:01C4C6B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Greg KH [mailto:greg@kroah.com] 
>Sent: Tuesday, November 09, 2004 3:44 PM
>To: Pallipadi, Venkatesh
>Cc: dtor_core@ameritech.net; Kay Sievers; linux-kernel@vger.kernel.org
>Subject: Re: /sys/devices/system/timer registered twice
>
>On Tue, Nov 09, 2004 at 03:41:51PM -0800, Pallipadi, Venkatesh wrote:
>> 
>> But, do we really need two system devices for timers?. I feel 
>> we can call setup_pit_timer from time.c, whenever pit is being used.
>> Otherwise, we may have more issues like the order in which these 
>> two resumes are called and the like.
>
>I have no idea.  Why not work this out with the other system device
>authors, as it's obvious people will have both of them loaded at the
>same time.
>

Agreed. We can change the name of the one in timer_pit.c to timer_pit 
for now. That will fix the immediate breakage.
I will try to come up with a patch to combine the two, soon.

Thanks,
Venki
