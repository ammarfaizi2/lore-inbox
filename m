Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWEHPQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWEHPQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWEHPQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:16:06 -0400
Received: from spirit.analogic.com ([204.178.40.4]:45061 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932375AbWEHPQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:16:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <445F5228.7060006@wipro.com>
X-OriginalArrivalTime: 08 May 2006 15:16:03.0239 (UTC) FILETIME=[52043370:01C672B2]
Content-class: urn:content-classes:message
Subject: Re: How to read BIOS information
Date: Mon, 8 May 2006 11:16:02 -0400
Message-ID: <Pine.LNX.4.61.0605081105590.22796@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to read BIOS information
Thread-Index: AcZyslIqwA0H06kBTg+PH0Bqo3i0HA==
References: <445F5228.7060006@wipro.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Madhukar Mythri" <madhukar.mythri@wipro.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 May 2006, Madhukar Mythri wrote:

> Hi,
>     Im new to this group.
> I want to get some information from BIOS. i.e i want to know whether
> Hyperthreading is Enabled/Disabled(as per BIOS settings)  from an user
> applications program.
>
> Please reply, if anybody has worked on it.
>

The BIOS settings, and where the BIOS information is stored, is
different for each and every BIOS. That's why there is a BIOS
setup screen. You can't run this screen from within the 32-bit
protected-mode environment of Linux. You could, however, implement
a VM-86 environment, just as is done for dosemu, the MS-DOS
emulator. However, dosemu creates a virtual BIOS environment and
doesn't use the real one, therefore you would have to copy over
a the real BIOS pages in order to run the BIOS setup screen.

The bottom line is that it's possible, but very difficult. That's
why relevant information is gathered by Linux and put into
the /proc file-system. If you have hyper-threading, it should
show up as two or more CPUs in /proc/cpuinfo.

> --
> Thanks & Regards
> Madhukar Mythri
> Wipro Technologies
> Bangalore.
> Off: +91 80 30294361.
> M: +91 9886442416.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
