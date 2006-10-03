Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWJCOSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWJCOSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWJCOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:18:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:32776 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750883AbWJCOSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:18:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 03 Oct 2006 14:17:59.0875 (UTC) FILETIME=[BAE80930:01C6E6F6]
Content-class: urn:content-classes:message
Subject: Re: error to be returned while suspended
Date: Tue, 3 Oct 2006 10:17:59 -0400
Message-ID: <Pine.LNX.4.61.0610031014070.21369@chaos.analogic.com>
In-Reply-To: <200610031502.33545.oliver@neukum.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error to be returned while suspended
thread-index: Acbm9rsJV8T3X37jRAic51PaJ2oe+A==
References: <200610031323.00547.oliver@neukum.org> <Pine.LNX.4.61.0610030846040.21211@chaos.analogic.com> <200610031502.33545.oliver@neukum.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Oct 2006, Oliver Neukum wrote:

> Am Dienstag, 3. Oktober 2006 14:51 schrieb linux-os (Dick Johnson):
>>
>> On Tue, 3 Oct 2006, Oliver Neukum wrote:
>>
>>> Hi,
>>>
>>> which error should a character device return if a read/write cannot be
>>> serviced because the device is suspended? Shouldn't there be an error
>>> code specific to that?
>>>
>>> 	Regards
>>> 		Oliver
>>
>> The de-facto error codes were created long before one could "suspend"
>> a device, so there isn't a ESUSP code. However, I suggest EIO or EBUSY
>
> CUPS chokes on these. Is it acceptable to say that you should know
> what you're doing when suspending?
>

Well, you need to look at the CUPS documentation and find out
what return code would be non-fatal and tell it to buffer stuff
to try later (such as the return code you get when the printer
if off-line).

 	http://www.cups.org/documentation.php

>> unless you want to define an ESUSP and get it accepted by the POSIX
>> committee.
>

Even if you did that, CUPS would have to be modified to accept
the new error code. There should be a current error code that
will allow CUPS to continue.

> This would be the cleanest solution. How does one do that?
>
> 	Regards
> 		Oliver
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
