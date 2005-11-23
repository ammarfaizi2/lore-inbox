Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVKWOT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVKWOT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKWOT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:19:59 -0500
Received: from spirit.analogic.com ([204.178.40.4]:26887 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750791AbVKWOT6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:19:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
X-OriginalArrivalTime: 23 Nov 2005 14:19:50.0729 (UTC) FILETIME=[F7458390:01C5F038]
Content-class: urn:content-classes:message
Subject: Re: Use enum to declare errno values
Date: Wed, 23 Nov 2005 09:19:50 -0500
Message-ID: <Pine.LNX.4.61.0511230908320.17975@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Use enum to declare errno values
Thread-Index: AcXwOPdpm3jw4hbLTcaPfQ5D4zlAyw==
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "moreau francis" <francis_moreau2000@yahoo.fr>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, moreau francis wrote:

> Hi,
>
> I'm just wondering why not declaring errno values using enumaration ?
> It is just more convenient when debuging the kernel.
>
> Thanks

There is an attempt to keep kernel errno values similar to
user-mode errno values. This simplifies the user-kernel
interface where the kernel will return -ERRNO and the user-mode
code negates it and puts it into the user errno then sets the
return value to -1 (a Unix convention).

The user-mode errno's therefore must correspond. You can't
expect the 'C' runtime libraries to be rebuilt and/or all the
programs recompiled just because the kernel got changed so
the errno's are hard-coded. 0 will always mean "no error" and
1 will always be EPERM, etc. There are error-codes that are
the same number also, EWOULDBLOCK and EAGAIN are examples.

So, you can't just auto-enumerate. If auto-enumeration isn't
possible, then you might just as well use #define, which is
what is done.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
