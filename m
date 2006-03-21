Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWCULq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWCULq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWCULq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:46:58 -0500
Received: from spirit.analogic.com ([204.178.40.4]:55558 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030364AbWCULq5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:46:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200603210849.20224.yarick@it-territory.ru>
x-originalarrivaltime: 21 Mar 2006 11:46:48.0697 (UTC) FILETIME=[23191E90:01C64CDD]
Content-class: urn:content-classes:message
Subject: Re: VFAT: Can't create file named 'aux.h'?
Date: Tue, 21 Mar 2006 06:46:47 -0500
Message-ID: <Pine.LNX.4.61.0603210644530.1898@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VFAT: Can't create file named 'aux.h'?
Thread-Index: AcZM3SM1HS1xC68MS3GfY6X5fkUOTg==
References: <1142890822.5007.18.camel@localhost.localdomain> <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr> <200603210849.20224.yarick@it-territory.ru>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Yaroslav Rastrigin" <yarick@it-territory.ru>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2006, Yaroslav Rastrigin wrote:

> Hi,
> On 21 March 2006 00:46, you wrote:
>>> 	Hi everybody,
>>>
>>> while trying to back up a couple Linux directories to a FAT disk I ran
>>> into a weird situation: I can't create a file called aux.h on the FAT
>>> system!
>>>
>> On DOS et al, there are a number of special filenames, such as
>>
>> 	com1:
>> 	com2: (and so on)
>> 	lpt1:
>> 	lpt2: (and so on)
>> 	con:
>> 	aux
>> 	nul
>>
>> (Try `dir >nul`, it's equivalent to unix's `ls -l >/dev/null` --
>> aux is the auxiliary port, whatever that is)
>>
>> It seems only fair to me to not allow creating these files under Linux
>> either, to avoid problems when booting back to Dos/Windows.
> This is true. smbfs, OTOH, has no such checks, so creating aux.h on an smb share is one easy way to DoS
> all WinXP machines using(browsing) this share. Explorer hangs on reading directory with this file.
>>
>>
>> Jan Engelhardt
>
> --
> Managing your Territory since the dawn of times ...

Also, CON is a sensitive name on WIN/2000. This can hang the
browser. The "@#+^%!@#" devices still exist:

C:\> copy con xxx.xxx

.... from the shell will wait forever.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
