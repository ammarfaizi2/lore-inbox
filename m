Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSA3SU2>; Wed, 30 Jan 2002 13:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289917AbSA3SSv>; Wed, 30 Jan 2002 13:18:51 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:12596 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S290293AbSA3SSW>; Wed, 30 Jan 2002 13:18:22 -0500
Message-ID: <00b501c1a9ba$93544830$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.kdqjrkv.1d44lam@ifi.uio.no>
Subject: Re: TCP/IP Speed
Date: Wed, 30 Jan 2002 13:18:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I ping two linux machines on a private link, I get 0.1 ms delay.
> When I send large TCP/IP stream data between them, I get almost
> 10 megabytes per second on a 100-base link. Wonderful.
> 
> However, if I send 64 bytes from one machine and send it back, simple
> TCP/IP strean connection, it takes 1 millisecond to get it back? There
> seems to be some artifical delay somewhere.  How do I turn this OFF?

Stupid question - did you turn Nagle off?

int one = 1;
setsockopt(fd, SOL_TCP, TCP_NDELAY, &one);

(I think; typing from memory...)

Regards,
Dan

