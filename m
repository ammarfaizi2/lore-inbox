Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCVWWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCVWWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCVWWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:22:43 -0500
Received: from spirit.analogic.com ([204.178.40.4]:36875 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932162AbWCVWWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:22:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4421C8C9.10007@cfl.rr.com>
x-originalarrivaltime: 22 Mar 2006 22:22:36.0459 (UTC) FILETIME=[1F5967B0:01C64DFF]
Content-class: urn:content-classes:message
Subject: Re: VFAT: Can't create file named 'aux.h'?
Date: Wed, 22 Mar 2006 17:22:36 -0500
Message-ID: <Pine.LNX.4.61.0603221705510.1531@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VFAT: Can't create file named 'aux.h'?
Thread-Index: AcZN/x9gGgvhx6J9RZW0Owoai75mag==
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01. <87y7z2l159.fsf@duaron.myhome.or.jp> <4421C8C9.10007@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
       "H. Peter Anvin" <hpa@zytor.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2006, Phillip Susi wrote:

> It appears to simply be stored as "aux" under windows.  The filesystem
> itself has no reserved names.  The handling of AUX and CON and friends
> is just special case handling done at the win32 api level.
>
> OGAWA Hirofumi wrote:
>> Could you/anyone check what shortname is used for "AUX" if it is created
>> in cmd.exe?
>>
>> Windows may be storing it as shortname, because it seems to be using
>> completely separated namespace for devices (I guessed from result of
>> google).
>>
>> Thanks.
>

Under win/2000 "aux" can't be created either by using C/C++ or
any of the usual utilities like `ftp`. The returned error-code
is "Permission denied", even from an administrator account.

I have a dual-boot lap-top so I tried to create a file called
"AUX" using `echo "">AUX`, under Linux-2.4.26. The error-code
was "Invalid argument". This is a "vfat" file-system. I was
able to create the device-name "CLOCK$", which is reserved in
DOS. I'm now rebooting the laptop, it should be interesting
to see if it still works! .... Yep. It's not a reserved name
in Win/2000.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
