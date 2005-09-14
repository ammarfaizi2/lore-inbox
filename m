Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVINPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVINPRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVINPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:17:04 -0400
Received: from spirit.analogic.com ([208.224.221.4]:19218 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965230AbVINPRC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:17:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026F9E@xpserver.intra.lexbox.org>
References: <17AB476A04B7C842887E0EB1F268111E026F9E@xpserver.intra.lexbox.org>
X-OriginalArrivalTime: 14 Sep 2005 15:17:00.0303 (UTC) FILETIME=[5A8A79F0:01C5B93F]
Content-class: urn:content-classes:message
Subject: RE: Corrupted file on a copy
Date: Wed, 14 Sep 2005 11:16:59 -0400
Message-ID: <Pine.LNX.4.61.0509141114060.17802@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Corrupted file on a copy
Thread-Index: AcW5P1qRua5rs4yuQFGlF+okL4NXfg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Sanchez" <david.sanchez@lexbox.fr>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Sep 2005, David Sanchez wrote:

> Unfortunately, the cmp command shows me a difference between the 2 files!
> I known that it is a strange behaviour and that probably come from my code but I don't find it yet :(
> More, I try the last linux kernel 2.6.13 from linux-mips.org with the last busybox version and the problem persists!
>

Yes, but 'cmp' can tell you the offset where the bytes differ.
This should let you know if you have "off-by-one" errors, etc., in
your code. For instance, if you have a 64k sized buffer and your
first bad byte offset is at 0xffff, then that should tell you
something (like the code logic has interchanged length and offset).


>
> David SANCHEZ
> LexBox :: The Digital Evidence
> 3, avenue Didier Daurat
> 31400 TOULOUSE / FRANCE
> david.sanchez@lexbox.fr
> Tel :  +33 (0)5 62 47 15 81
> Fax : +33 (0)5 62 47 15 84
> -----Message d'origine-----
> De : linux-os (Dick Johnson) [mailto:linux-os@analogic.com]
> Envoyé : mercredi 14 septembre 2005 16:46
> À : David Sanchez
> Cc : linux-kernel@vger.kernel.org
> Objet : Re: Corrupted file on a copy
>
>
> On Wed, 14 Sep 2005, David Sanchez wrote:
>
>> Hi,
>>
>> I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550 board.
>>
>> When I copy a big file (around 300M) within an ext2 filesystem (even on
>> ext3 filesystem) then the output file is sometime "corrupted" (I mean
>> that the source and the destination files are different and thus
>> generate a different SHA1).
>> Does somebody have a same behaviour?
>>
>> Thanks,
>> David
>>
>
> Use `cmp` to compare the two files. You could have discovered
> a bug in your checksum utility, you need to isolate it to
> the file-system. FYI, I have never seen a copy of a file, including
> the image of an entire DVD (saved to clone another), that was not
> properly identical.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> I apologize for the following. I tried to kill it with the above dot :
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
>
> Thank you.
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
