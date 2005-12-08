Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLHPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLHPQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVLHPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:16:40 -0500
Received: from spirit.analogic.com ([204.178.40.4]:13331 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932118AbVLHPQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:16:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4398493E.50508@labri.fr>
X-OriginalArrivalTime: 08 Dec 2005 15:16:38.0960 (UTC) FILETIME=[62EE8B00:01C5FC0A]
Content-class: urn:content-classes:message
Subject: Re: How to enable/disable security features on mmap() ?
Date: Thu, 8 Dec 2005 10:16:38 -0500
Message-ID: <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to enable/disable security features on mmap() ?
Thread-Index: AcX8CmMLZ88Rjb/tRNuIfAkfALn3QQ==
References: <43983EBE.2080604@labri.fr>  <1134051272.2867.63.camel@laptopd505.fenrus.org>  <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Emmanuel Fleury" <emmanuel.fleury@labri.fr>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Emmanuel Fleury wrote:

> Arjan van de Ven wrote:
>>
>> well it's a /proc/ variable already! So you can just turn it off
>> entirely at runtime. (what is better is that you use the setarch program
>> to turn it off for selected programs though...)
>
> I knew it was a stupid question ! I fooled myself once more ! ;-)
> I'll take a look at this familly of variables and at the proc entries.
>
> Thanks a lot !
> --
> Emmanuel Fleury

In reference to the random-stack patch....

Executing the following program on linux-2.6.13.4:

#include <stdio.h>

int main()
{
     int foo;
     printf("%p\n", &foo);
     return 0;
}

... a few thousand times and sorting its output shows
the stack varies from:
 	0xbf7fe144 -> 0xbffff674

Isn't this too much?  I thought the random-stack patch was
only supposed to vary it a page or 64k at most. This looks
like some broken logic because it varies almost 8 megabytes!
No wonder some of my user's database programs sometimes seg-fault
and other times work perfectly fine. I think this is incorrect
and shows a serious bug (misbehavior).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
