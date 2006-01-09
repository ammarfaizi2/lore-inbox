Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWAIPbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWAIPbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWAIPbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:31:13 -0500
Received: from spirit.analogic.com ([204.178.40.4]:31243 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964784AbWAIPbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:31:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060109141958.GM2767@charite.de>
X-OriginalArrivalTime: 09 Jan 2006 15:31:08.0136 (UTC) FILETIME=[B6384680:01C61531]
Content-class: urn:content-classes:message
Subject: Re: kernel BUG at drivers/ide/ide.c:1384!
Date: Mon, 9 Jan 2006 10:30:47 -0500
Message-ID: <Pine.LNX.4.61.0601091025480.17766@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel BUG at drivers/ide/ide.c:1384!
Thread-Index: AcYVMbY/w17Jr+lVQduuaffJVNxP4A==
References: <20060109095159.GE4535@charite.de> <1136816352.6659.10.camel@localhost.localdomain> <20060109141958.GM2767@charite.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ralf Hildebrandt" <Ralf.Hildebrandt@charite.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jan 2006, Ralf Hildebrandt wrote:

> * Alan Cox <alan@lxorguk.ukuu.org.uk>:
>
>> You should be able to reproduce it without the Nvidia code loaded if you
>> do I/O on the disk and run hdparm -w in a tight loop while doing so.
>>
>> You might want to do it on a disk you have a backup of
>
> I think I'll pass :)
> --
> Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
> Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
> Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
> IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de

He might be able to do the same thing with `cat /dev/urandom > /dev/hda`.
There are not a lot of file-system checks against bad data in file-systems.
The '-w' reset will guarantee bad data, which may propagate to the
file-system(s) in use, causing all kinds of problems. So, the OOPS under
these conditions is expected.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.71 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
