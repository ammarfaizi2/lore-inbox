Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWAZXQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWAZXQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWAZXQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:16:39 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:20812 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S1030225AbWAZXQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:16:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: USB host pci-quirks
Date: Thu, 26 Jan 2006 15:16:35 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3AA368B@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB host pci-quirks
Thread-Index: AcYiyUHp0H4muZUSRziE96QAQ4E8+QABHMpA
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Oskar Senft" <osk-lkml@sirrix.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2006 23:16:37.0392 (UTC) FILETIME=[8E604900:01C622CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Oskar Senft [mailto:osk-lkml@sirrix.de] 
>Sent: Thursday, January 26, 2006 2:38 PM
>To: Aleksey Gorelov; linux-kernel@vger.kernel.org
>Subject: Re: USB host pci-quirks
>
>Dear Aleksey,
>
>thank you for your e-mail!
>
>>>Is there a special need, that the "drivers/usb/host/pci-quirks.c" is
>>>compiled into the kernel even if USB support is disabled?
>> 
>>   Yes, there is. USB handoff is necessary even if USB support is
>> disabled completely in kernel. In fact, initially early usb 
>handoff code
>> was under pci, but since USB drivers do handoff anyway, it 
>was decided
>> to move everything into usb with a goal of merging them together. 
>>   Just search for USB handoff in kernel archives.
>
>I see ... but as David Brownell already stated on Thu Sep 02 2004 -
>20:07:57 EST:
>For backwards compatibility, the early reset should not be the
>default. There aren't many systems where it's a problem.
>
>What happened to that argument?

There's been a lot of reports since then for hardware which does require
handoff. Hence it's been made default. I did not see any compatibility
issues, but that does not mean they do not exist.

Aleks.

>
>Regards,
>Oskar.
>
