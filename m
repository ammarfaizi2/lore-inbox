Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVI0MwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVI0MwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVI0MwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:52:23 -0400
Received: from spirit.analogic.com ([204.178.40.4]:53770 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964914AbVI0MwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:52:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200509261928.20701.shawn.starr@rogers.com>
References: <200509261928.20701.shawn.starr@rogers.com>
X-OriginalArrivalTime: 27 Sep 2005 12:52:19.0693 (UTC) FILETIME=[4BDD41D0:01C5C362]
Content-class: urn:content-classes:message
Subject: Re: Crazy Idea: Replacing /dev using sysfs over time
Date: Tue, 27 Sep 2005 08:52:19 -0400
Message-ID: <Pine.LNX.4.61.0509270844040.3867@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Crazy Idea: Replacing /dev using sysfs over time
Thread-Index: AcXDYkv5AqtRPaqFQTayieAJZYXeBA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Shawn Starr" <shawn.starr@rogers.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Sep 2005, Shawn Starr wrote:

> I wonder if in the future, we can just eliminate /dev altogether (or map it
> via sysfs until older apps move away from /dev). It just seems we could
> represent major,minor in a sysfs node:
>
>        /sys/class/block/
>        `-- sda
>            |-- sda1
>                    | - major
>                    | - minor
>                    | - raw
>            |-- sda2
>                    | - major
>                    | - minor
>                    | - raw
>            `-- sda3
>
> and so forth, or under a different branch elsewhere.
>
> Does it make sense? Logical? Illogical? Do we really need /dev other than for
> historical/legacy purposes?
>
> Shawn.

Already been done. We have "devfs" in the kernel. FYI, you
don't need "/dev". The devices-files are just a way of associating
a major/minor number with a file-descriptor. It's convenient and
neat to have them all at a known location, just like having
configuration files in "/etc".

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
