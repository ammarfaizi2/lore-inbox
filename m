Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVKJP2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVKJP2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKJP2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:28:44 -0500
Received: from spirit.analogic.com ([204.178.40.4]:34822 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750845AbVKJP2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:28:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43735766.3070205@gmail.com>
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com>
X-OriginalArrivalTime: 10 Nov 2005 15:28:42.0469 (UTC) FILETIME=[6E9C4150:01C5E60B]
Content-class: urn:content-classes:message
Subject: Re: MOD_INC_USE_COUNT
Date: Thu, 10 Nov 2005 10:28:41 -0500
Message-ID: <Pine.LNX.4.61.0511101024370.20139@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MOD_INC_USE_COUNT
Thread-Index: AcXmC269xv+TMzqiQJezRTaPhA9Jqw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Tony" <tony.uestc@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Nov 2005, Tony wrote:

> linux-os (Dick Johnson) wrote:
>> On Thu, 10 Nov 2005, Tony wrote:
>>
>>
>>> Hello All,
>>> Usually, when a net_device->open is called, it will MOD_INC_USE_COUNT on
>>> success. It is removed since 2.5.x, then should I increase the use
>>> count? how? thx.
>>
>>
>> Gone! Don't use INC or DEC_USE_COUNT anymore. The kernel takes
>> care of that for you. Also, the count shown in `lsmod` no longer
>> means anything you can use programmaticly.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
>> Warning : 98.36% of all statistics are fiction.
>>
>>
> But when the module is used by a net_device(interface is up), rmmod also
> works. Strange, isn't it?

Yes, it does something unexpected, i.e., violates the tenant of
least surprise. It shuts down the network interface, doesn't even
log the event. It just __does__ it!  At least M$ would put the
information in the "event viewer".
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
