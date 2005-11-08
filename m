Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVKHSUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKHSUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVKHSUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:20:10 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:6925 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751046AbVKHSUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:20:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com> <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net>
X-OriginalArrivalTime: 08 Nov 2005 18:20:06.0772 (UTC) FILETIME=[0BB4DB40:01C5E491]
Content-class: urn:content-classes:message
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 13:20:06 -0500
Message-ID: <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compatible fstat()
Thread-Index: AcXkkQu+GLxeflKPS2eTF+9MKjNXTw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Parag Warudkar" <kernel-stuff@comcast.net>
Cc: "Al Viro" <viro@ftp.linux.org.uk>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Parag Warudkar wrote:

>
>>
>> I think it's just a syntax error...
>>
>>>> 	size = lseek(fd, 0, SEEK_SET);
>>                              |___________  Whence at the end
>>
>> ... will do fine on three different systems so far.
>>
>
> Yeah I corrected that before trying but still didn't work on Debian
> (2.6.8 kernel)...
> Running root, open successful but size is always zero - Strange..
>
> Parag

Also found that the returned value was -1 and errno was EOVERFLOW.
So, that doesn't work either!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
