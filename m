Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRB0Bf0>; Mon, 26 Feb 2001 20:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRB0BfR>; Mon, 26 Feb 2001 20:35:17 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:13 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S129409AbRB0BfB>;
	Mon, 26 Feb 2001 20:35:01 -0500
Message-ID: <001101c0a05c$825f4150$0201a8c0@mojo>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Ivan Passos" <lists@cyclades.com>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        "Linux Serial List" <linux-serial@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10102261651000.15230-100000@main.cyclades.com>
Subject: Re: CLOCAL and TIOCMIWAIT
Date: Mon, 26 Feb 2001 19:27:54 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A customer has just brought to my attention that when you try to use the
> TIOCMIWAIT ioctl with our boards and CLOCAL is enabled, you can't check
> changes in the DCD signal. He also mentioned that that is possible with
> the regular serial ports.
>
> As I understood, CLOCAL meant disabling DCD sensitivity, so if CLOCAL is
> disabled, no changes in DCD will be passed from hardware driver to the
> kernel or userspace. The way the serial driver is implemented, this is not
> true (i.e. even with CLOCAL enabled, you can still see DCD changes through
> the TIOCMIWAIT command).
>
> My question is: what's the correct interpretation of CLOCAL?? If the
> serial driver's interpretation is the correct one, I'll be more than happy
> to change the Cyclades' driver to comply with that, I just want to make
> sure that this is the expected behavior before I patch the driver.
>
> Thanks in advance for your comments.
>
> Later,
> Ivan

I believe CLOCAL only governs how DCD is used (or ignored) when opening
a port (must be active to complete open) and maintaining a connection
(negation signals hangup).

So CLOCAL controls the driver's 'interpretation' of DCD but
TIOCMIWAIT monitors the signal transitions without regard to
a predefined interpretation (let's the application decide what
to do with DCD).

Paul Fulghum
paulkf@microgate.com


