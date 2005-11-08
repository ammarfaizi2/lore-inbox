Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVKHR4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVKHR4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVKHR4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:56:07 -0500
Received: from spirit.analogic.com ([204.178.40.4]:13317 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932497AbVKHR4F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:56:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051108172244.GR7992@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk>
X-OriginalArrivalTime: 08 Nov 2005 17:56:04.0481 (UTC) FILETIME=[B008B710:01C5E48D]
Content-class: urn:content-classes:message
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 12:56:04 -0500
Message-ID: <Pine.LNX.4.61.0511081255240.4476@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compatible fstat()
Thread-Index: AcXkjbAqsAvu6fArSf2AjqeqNxWWLg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Cc: "Parag Warudkar" <kernel-stuff@comcast.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Al Viro wrote:

> On Tue, Nov 08, 2005 at 12:10:25PM -0500, Parag Warudkar wrote:
>>
>> On Nov 8, 2005, at 10:48 AM, linux-os ((Dick Johnson)) wrote:
>>
>>> The Linux fstat() doesn't return any information number of blocks,
>>> or the byte-length of a physical hard disk.
>>
>> I don't think (f)stat returns size and blocks information about a
>> block device on any UNIX platform.
>>
>> But I don't know for sure how to get it - perhaps ioctl on the
>> device? BLKGETSIZE?
>
> 	fd = open(bdev, O_RDONLY);
> 	lseek(fd, SEEK_END, 0);
> 	size = lseek(fd, SEEK_SET, 0);
> 	close(fd);
>
> i.e. same as for regular files.  Won't be portable, though...
>
I think lseek has more of a chance than ioctl(), though.
Thanks.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
