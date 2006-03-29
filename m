Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWC2PFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWC2PFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWC2PFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:05:55 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2820 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750791AbWC2PFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:05:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <000701c65340$d9736ab0$b600a8c0@cortex>
x-originalarrivaltime: 29 Mar 2006 15:05:51.0388 (UTC) FILETIME=[44CD25C0:01C65342]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] fat: kill reserved names
Date: Wed, 29 Mar 2006 10:05:51 -0500
Message-ID: <Pine.LNX.4.61.0603291003250.27913@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fat: kill reserved names
Thread-Index: AcZTQkTpUnj/RHBGRBm40yG81Prl4A==
References: <000701c65340$d9736ab0$b600a8c0@cortex>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Paul Rolland" <rol@witbe.net>
Cc: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2006, Paul Rolland wrote:

> Hello,
>
>> Since these names on old MSDOS is used as device, so, current fat
>> driver doesn't allow a user to create those names.  But many OSes and
>> even Windows can create those names actually, now.
>>
>> This patch removes the reserved name check.
>>
>> -/* MS-DOS "device special files" */
>> -static const unsigned char *reserved_names[] = {
>> -	"CON     ", "PRN     ", "NUL     ", "AUX     ",
>> -	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
>> -	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
>> -	NULL
>
> Please don't :
>
> Microsoft Windows XP [Version 5.1.2600]
> (C) Copyright 1985-2001 Microsoft Corp.
>
> D:\>mkdir LPT1
> The directory name is invalid.
>
> Windows doesn't want these !!!
>
> Regards,
> Paul

Well somebody else showed that it's the API that doesn't want
those, not the file-system. So, if you have a file called
AUX and you click on it, it will hang the machine until you
Ctrl-Alr-Del to the Task manager and kill the task. This
is supposed to be okay.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
