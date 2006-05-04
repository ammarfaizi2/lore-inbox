Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWEDR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWEDR4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWEDR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:56:35 -0400
Received: from spirit.analogic.com ([204.178.40.4]:20497 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030246AbWEDR4e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:56:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0605041940540.29706@yvahk01.tjqt.qr>
X-OriginalArrivalTime: 04 May 2006 17:56:32.0812 (UTC) FILETIME=[14096EC0:01C66FA4]
Content-class: urn:content-classes:message
Subject: Re: TCP/IP send, sendfile, RAW
Date: Thu, 4 May 2006 13:56:31 -0400
Message-ID: <Pine.LNX.4.61.0605041345190.6861@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TCP/IP send, sendfile, RAW
thread-index: AcZvpBQoeEGJtRy5QZuxy5PQTLXsbQ==
References: <BAY105-F1952B97471150282623600E9B40@phx.gbl> <Pine.LNX.4.61.0605041940540.29706@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Roy Rietveld" <rwm_rietveld@hotmail.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 May 2006, Jan Engelhardt wrote:

>> I would like to send ethernet packets with 1400 bytes payload.
>> I wrote a small program witch sends a buffer of 1400 bytes in a endless loop.
>> The problem is that a would like 100Mbits throughtput but when i check this
>> with ethereal.
>> I only get 40 MBits. I tried sending with an UDP socket and RAW socket. I also
>> tried sendfile.
>> The RAW socket gives the best result till now 50 MBits throughtput.
>
> Limitation of Ethernet.
>
>
>
> Jan Engelhardt

Maybe he can tell what he means by 100 MBits! If he is looking for
100 megabits per second, that's easy, That's 100/8 = 12.5 megabytes
per second. Anything, including Windows on a wet string, will
do that. If he is looking for 100 megabytes per second, that's
hard. He would need 100 * 8 = 800 megabits/second. A "gigabit" link
runs that fast if nobody else is on it, but there is a header and CRC
tail, in addition to the payload. UDP is the protocol to use to realize
this kind of bandwidth, but its possible for some packets to get lost and,
if they are routed, they could even be duplicated. Also, when testing
UDP, there must be a listener in order to realize the high speed.
You can't just spew out a dead-end link.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
