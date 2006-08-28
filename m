Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWH1OPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWH1OPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWH1OPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:15:23 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:14803 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1750878AbWH1OPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:15:20 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Rogier Wolff'" <R.E.Wolff@BitWizard.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-os \(Dick Johnson\)'" <linux-os@analogic.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>,
       "'David Woodhouse'" <dwmw2@infradead.org>,
       <linux-serial@vger.kernel.org>, "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial custom speed deprecated?
Date: Mon, 28 Aug 2006 10:14:30 -0400
Organization: Connect Tech Inc.
Message-ID: <000901c6caac$478bfca0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060827065210.GA6932@bitwizard.nl>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Rogier Wolff
> Note that IMHO, we should have started hiding this mess from /drivers/
> a long time ago. The tty layer should convert the B_9600 thingies to
> "9600", the integer, and then call the set_termios function. The
> driver should be prohibited from looking at how the the baud rate came
> to be 9600, and attempt to approach the requested baud rate as good as
> possible. It might return a flag somewhere: Not exact. In the example
> above, the resulting baud rate is about 1.4 baud off: 9598.6. This is
> not a problem in very many cases.
> 
> Once this is in place, you lose a lot of "figure out the baud rate
> integer from the B_xxx settings" code in all the drivers, as well as
> that we get to provide a new interface to userspace without having to
> change ALL drivers at the same time. This decouples the drivers from
> the kernel<->userspace interface.

I'll second the motion. :-)

..Stu

