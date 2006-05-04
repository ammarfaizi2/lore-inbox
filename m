Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWEDSFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWEDSFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWEDSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:05:14 -0400
Received: from bay105-f39.bay105.hotmail.com ([65.54.224.49]:61906 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750766AbWEDSFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:05:13 -0400
Message-ID: <BAY105-F393958BBFE20D29F8C6C82E9B40@phx.gbl>
X-Originating-IP: [80.100.253.167]
X-Originating-Email: [rwm_rietveld@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0605041345190.6861@chaos.analogic.com>
From: "Roy Rietveld" <rwm_rietveld@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-os@analogic.com, jengelh@linux01.gwdg.de
Subject: Re: TCP/IP send, sendfile, RAW
Date: Thu, 04 May 2006 18:05:09 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 04 May 2006 18:05:12.0511 (UTC) FILETIME=[49CD34F0:01C66FA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it is 100 MBits and there is a listener. and there are no other pc's on 
the link because its cross cable link. And when sending large buffers 
32Kbyte it will do 80 MBits. It think that there is a lot of overhead in the 
fucntion send or something.


>From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
>CC: "Roy Rietveld" 
><rwm_rietveld@hotmail.com>,<linux-kernel@vger.kernel.org>
>Subject: Re: TCP/IP send, sendfile, RAW
>Date: Thu, 4 May 2006 13:56:31 -0400
>
>
>On Thu, 4 May 2006, Jan Engelhardt wrote:
>
> >> I would like to send ethernet packets with 1400 bytes payload.
> >> I wrote a small program witch sends a buffer of 1400 bytes in a endless 
>loop.
> >> The problem is that a would like 100Mbits throughtput but when i check 
>this
> >> with ethereal.
> >> I only get 40 MBits. I tried sending with an UDP socket and RAW socket. 
>I also
> >> tried sendfile.
> >> The RAW socket gives the best result till now 50 MBits throughtput.
> >
> > Limitation of Ethernet.
> >
> >
> >
> > Jan Engelhardt
>
>Maybe he can tell what he means by 100 MBits! If he is looking for
>100 megabits per second, that's easy, That's 100/8 = 12.5 megabytes
>per second. Anything, including Windows on a wet string, will
>do that. If he is looking for 100 megabytes per second, that's
>hard. He would need 100 * 8 = 800 megabits/second. A "gigabit" link
>runs that fast if nobody else is on it, but there is a header and CRC
>tail, in addition to the payload. UDP is the protocol to use to realize
>this kind of bandwidth, but its possible for some packets to get lost and,
>if they are routed, they could even be duplicated. Also, when testing
>UDP, there must be a listener in order to realize the high speed.
>You can't just spew out a dead-end link.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
>New book: http://www.lymanschool.com
>_
>
>
>****************************************************************
>The information transmitted in this message is confidential and may be 
>privileged.  Any review, retransmission, dissemination, or other use of 
>this information by persons or entities other than the intended recipient 
>is prohibited.  If you are not the intended recipient, please notify 
>Analogic Corporation immediately - by replying to this message or by 
>sending an email to DeliveryErrors@analogic.com - and destroy all copies of 
>this information, including any attachments, without reading or disclosing 
>them.
>
>Thank you.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


