Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVHJTzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVHJTzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVHJTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:55:05 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:52748 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030215AbVHJTzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:55:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 10 Aug 2005 19:55:02.0878 (UTC) FILETIME=[65AC27E0:01C59DE5]
Content-class: urn:content-classes:message
Subject: CCITT-CRC16 in kernel
Date: Wed, 10 Aug 2005 15:54:52 -0400
Message-ID: <Pine.LNX.4.61.0508101549280.10525@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CCITT-CRC16 in kernel
Thread-Index: AcWd5WXBp/Iq+LlzRTWWC0p/BzN0BQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello CRC Wizards,

I am trying to use ../linux-2.6.12/lib/crc_citt in a driver.
Basically, it doesn't return anything that closely resembles
the CCIT-16 CRC. I note that drivers that use it expect it
to return 0xf0b8 if it performs the CRC of something that
has the CRC appended (weird).

Does anybody know what the CRC of a known string is supposed
to be? I have documentation that states that the CCITT CRC-16
of "123456789" is supposed to be 0xe5cc and "A" is supposed
to be 0x9479. The kernel one doesn't do this. In fact, I
haven't found anything on the net that returns the "correct"
value regardless of how it's initialized or how it's mucked
with after the CRC (well I could just set the CRC to 0 and
add the correct number). Anyway, how do I use the crc_citt
in the kernel? I've grepped through some drivers that use
it and they all seem to check the result against some
magic rather than performing the CRC of data, but not the
CRC, then comparing it to the CRC. One should not have
to use magic to verify a CRC, one should just perform
a CRC on the data, but not the CRC, then compare the result
with the CRC. Am I missing something here?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
