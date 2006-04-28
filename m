Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWD1Qte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWD1Qte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWD1Qtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:49:33 -0400
Received: from spirit.analogic.com ([204.178.40.4]:64778 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030454AbWD1Qtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:49:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200604281636.MAA06562@arkroyal.cnchost.com>
X-OriginalArrivalTime: 28 Apr 2006 16:49:31.0933 (UTC) FILETIME=[B8ED7CD0:01C66AE3]
Content-class: urn:content-classes:message
Subject: Re: add a few integer math ops (sqrt, atan) to kernel headers?
Date: Fri, 28 Apr 2006 12:49:31 -0400
Message-ID: <Pine.LNX.4.61.0604281246210.7898@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: add a few integer math ops (sqrt, atan) to kernel headers?
thread-index: AcZq47kTLeUEospQQQ+AtiIvTP/6Rw==
References: <200604281636.MAA06562@arkroyal.cnchost.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rick Niles" <niles@rickniles.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Apr 2006, Rick Niles wrote:

> Forgive me if it's already in the kernel somewhere, but I need some basic (large) integer based math functions for a GPS device driver I maintain (OSGPS on sourceforge)and I've got to wonder if other drivers might be able use them.  Right now we have: sqrt(x), atan2(y, x), and rss(x,y) [root-sum-squared].  The functions just deal with large integers to compute anything reasonable.  Of course they're approximations since the output has to be an integer. The atan2() function returns an angle such that 1 radian == 16384.  It seems like these should go in some integer math kernel header file for everyone to use.
>
> I know what some of you are thinking right now.  That sort of math belongs in userspace, but to close a correlator tracking loop in real-time you need it in the device driver. Either than or require your userland program be a real-time program, which I'd rather not do.
>
> They're all less than 30 lines long. If people think this is a good idea, then I can submit a patch.  Suggestions about what to call this header file or where to put it are appreciated.  Also, if anyone wants to add more functions or improve the algorithm we use that would also be nice.
> -

I like it /usr/src/linux-`uname-r`/lib/math might be a good place for
that stuff. It needs to be enabled/disabled with the standard configure
script so it won't be real easy. It also should work on 64-bit systems.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
