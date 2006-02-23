Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWBWRqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWBWRqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBWRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:46:00 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:26896 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932366AbWBWRp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:45:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0602231811320.1279@yvahk01.tjqt.qr>
x-originalarrivaltime: 23 Feb 2006 17:45:57.0927 (UTC) FILETIME=[00B32B70:01C638A1]
Content-class: urn:content-classes:message
Subject: Re: Mapping to 0x0
Date: Thu, 23 Feb 2006 12:45:57 -0500
Message-ID: <Pine.LNX.4.61.0602231243460.14936@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mapping to 0x0
Thread-Index: AcY4oQDSG5R3VnMMTDO+yrDbvntvRw==
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr> <Pine.LNX.4.61.0602220920060.10177@chaos.analogic.com> <Pine.LNX.4.61.0602231811320.1279@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Feb 2006, Jan Engelhardt wrote:

>>> int main(void) {
>>>    int fd   = open("badcode.bin", O_RDONLY);
>>      int fd   = open("/dev/mem", O_RDWR);
>>
>>>    mmap(NULL, 4096, PROT_READ | PROT_EXEC, MAP_FIXED, fd, 0);
>>> }
>>>
>> No. In your demo code, page 0 gets memory-mapped into user space.
>> This allows user-mode code to access the first page of memory
>> and even read/write offset 0, still in user mode, with the
>> root privs that allowed you access to that page in the
>> first place.
>
> Only root can map to 0x0?
>
>> Everything you do, is still in user-mode.
>> You just own some physical memory that the kernel didn't
>> care about anyway.
>
> So you can't accidentally call a place in userspace from kernel context?
> (Including the case where set_fs(USER_DS) was used.)
>
>
> Jan Engelhardt
> --

Nope. Try it, you'll like it! Play around with it, you can relocate
some code to play at offset 0, copy it there, and then call it.
It can't do anything bad, just because it's at a certain offset.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
