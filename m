Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132182AbRCVU47>; Thu, 22 Mar 2001 15:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132183AbRCVU4s>; Thu, 22 Mar 2001 15:56:48 -0500
Received: from www.microgate.com ([216.30.46.105]:23307 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S132182AbRCVU4e>; Thu, 22 Mar 2001 15:56:34 -0500
Message-ID: <00b101c0b312$7385ddb0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Geir Thomassen" <geirt@powertech.no>, "Theodore Tso" <tytso@mit.edu>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no> <20010322140852.A4110@think> <3ABA6167.309E6DB2@powertech.no>
Subject: Re: Serial port latency
Date: Thu, 22 Mar 2001 14:55:38 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The serial port chip is 16550A, which has a built in fifo. Can this be
> the source of my problems ?
> 
> Geir

I thought about that. If the number of receive bytes in the RX FIFO
is less that the trigger level then a timeout has to occur before
getting the next receive data interrupt.

The 16550AF data book says that this timeout is 4 characters
from when the last byte is received. This is a maximum of 160ms
at 300bps (when using 12bit characters: 1 start + 8 data + parity + 2 stop).

So this would be smaller at 9600 and could not account
for the 500ms delay.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


