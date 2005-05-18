Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVERJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVERJqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVERJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:46:06 -0400
Received: from ind-iport-1.cisco.com ([64.104.129.195]:52913 "EHLO
	ind-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262145AbVERJpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:45:51 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.93,117,1115017200"; 
   d="scan'208"; a="35230989:sNHT21508632"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Disk write cache (Was: Hyper-Threading Vulnerability)
Date: Wed, 18 May 2005 17:45:23 +0800
Message-ID: <26A66BC731DAB741837AF6B2E29C10171E5590@xmb-hkg-413.apac.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disk write cache (Was: Hyper-Threading Vulnerability)
Thread-Index: AcVbX/qJtcC50EGCS8qqNYFr+wUDZgALbTYw
From: "Lincoln Dale \(ltd\)" <ltd@cisco.com>
To: "Eric D. Mudama" <edmudama@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 May 2005 09:45:26.0772 (UTC) FILETIME=[51EA4B40:01C55B8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

> On 5/16/05, Robert Hancock <hancockr@shaw.ca> wrote:
> > If the power to the drive is truly just cut, then this is basically 
> > what will happen. However, I have heard, for what it's 
> worth, that in 
> > many cases if you pull the AC power from a typical PC, the 
> Power Good 
> > signal from the PSU will be de-asserted, which triggers the 
> Reset line 
> > on all the buses, which triggers the ATA reset line, which triggers 
> > the drive to finish writing out the sector it is doing. There is 
> > likely enough capacitance in the power supply to do that 
> before the voltage drops off.
> 
> Yes, but as you said this isn't a power loss event.  It is a 
> hard reset with a full write cache, which all drives on the 
> market today respond to by flushing the cache.
> 
> According to the spec the time to flush can exceed 30s, so 
> your PSU better have some honkin caps on it to ensure data 
> integrity when you yank the power cord out of the wall.

why don't drive vendors create firmware which reserved a cache-sized
(e.g. 2MB) hole of internal drive space somewhere for such an event, and
a "cache flush caused by hard-reset" simply caused it to write the cache
to a fixed (contiguous) area of disk.

the same drive firmware on power-on could check that area and 'write
back' the data to the correct locations.

all said and done, why wouldn't a vendor (lets just say "Maxtor" :) )
implement something like this and market it as a feature?
i'd happily spend a few extra bucks for something that given a modern
PSU providing a few Hz of power (e.g. 50msec) provided higher data
reliability in case of power failure..


cheers,

lincoln.
