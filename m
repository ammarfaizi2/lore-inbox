Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVKHUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVKHUDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVKHUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:03:47 -0500
Received: from spirit.analogic.com ([204.178.40.4]:38413 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030206AbVKHUDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:03:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com> <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net> <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com> <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com>
X-OriginalArrivalTime: 08 Nov 2005 20:03:45.0715 (UTC) FILETIME=[867C4030:01C5E49F]
Content-class: urn:content-classes:message
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 15:03:45 -0500
Message-ID: <Pine.LNX.4.61.0511081454040.5271@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compatible fstat()
Thread-Index: AcXkn4aD1M8sdKOjTPOKjgZF2pBZ8g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bob Copeland" <email@bobcopeland.com>
Cc: "Parag Warudkar" <kernel-stuff@comcast.net>,
       "Al Viro" <viro@ftp.linux.org.uk>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Bob Copeland wrote:

>>> Yeah I corrected that before trying but still didn't work on Debian
>>> (2.6.8 kernel)...
>>> Running root, open successful but size is always zero - Strange..
>>>
>>> Parag
>>
>> Also found that the returned value was -1 and errno was EOVERFLOW.
>> So, that doesn't work either!
>
> Isn't this just because the device size is > 2**32?  What if you use fseeko(3)
> and #define _FILE_OFFSET_BITS 64?
>
> Okay, still not portable and there is probably a better way that doesn't rely
> on such nonsense.  For example, since you have a minimum size in mind,
> just seek that much and see if it works - you don't really need to know the
> whole disk size for that.  Or figure out the best way on all of your platforms
> and abstract it.
>
> -Bob

Well if I could __count__ on EOVERFLOW meaning there was plenty of
room, it would be okay. Also, if I could count on walking-up-the
ladder of some SEEK_SET code that would be good also.

Anyway. I'm still checking. It sure would have been helpful
if fstat returned the number of blocks and the block-size for
the device (as it implied by the existance of those members).
Unfortunately the only POSIX requirement is for the st_*time,
st_mode, st_ini, st_dev, and st_*id fields to contain meaningful
values, damn.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
