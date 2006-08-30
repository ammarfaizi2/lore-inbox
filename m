Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWH3RPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWH3RPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWH3RPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:15:17 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58123 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751175AbWH3RPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:15:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 30 Aug 2006 17:15:12.0482 (UTC) FILETIME=[DA639C20:01C6CC57]
Content-class: urn:content-classes:message
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 13:15:07 -0400
Message-ID: <Pine.LNX.4.61.0608301304230.13331@chaos.analogic.com>
In-Reply-To: <200608301902.20728.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][RFC] exception processing in early boot
Thread-Index: AcbMV9ptSkbAIFmkQSeUIVL7+UMr8w==
References: <20060830063932.GB289@1wt.eu> <200608301830.40994.ak@suse.de> <Pine.LNX.4.61.0608301251570.13282@chaos.analogic.com> <200608301902.20728.ak@suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <pageexec@freemail.hu>, "Willy Tarreau" <w@1wt.eu>, <Riley@williams.name>,
       <davej@redhat.com>, "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2006, Andi Kleen wrote:

>
>> Even the i286 and the 8086 support hlt. Is there some Cyrix chip that
>> you are trying to preserve? I think even those all implimented
>> hlt as well.
>
>
> According to the kernel code it's
>
> char    hlt_works_ok;   /* Problems on some 486Dx4's and old 386's */
>
> I don't know more details about what these problems were.
>
> -Andi
>

Oh yes. There were some buggy chips that would not let an interrupt
take the CPU out of hlt! However, what's wanted here is a hard-stop
which you get even with buggy chips because an interrupt won't
awaken them.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
