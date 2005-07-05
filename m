Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGEVOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGEVOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVGEVOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:14:03 -0400
Received: from smtp006.bizmail.sc5.yahoo.com ([66.163.175.83]:62809 "HELO
	smtp006.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261961AbVGEVG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:06:28 -0400
Reply-To: <matts@commtech-fastcom.com>
From: "Matt Schulte" <matts@commtech-fastcom.com>
To: <linux-kernel@vger.kernel.org>
Subject: Serial PCI driver in 2.6.x kernel (i.e. 8250_pci HOWTO)
Date: Tue, 5 Jul 2005 16:06:22 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNOEBECLAA.matts@commtech-fastcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am paraphrasing my thread "development of serial driver" from the
linux-serial list.  I have not received much of a response on the serial
list.  I have noticed that there seems to be a fair amount of serial traffic
on this list and I am hoping to do a little bit better here.

When you respond, can you please copy the serial list at
linux-serial@vger.kernel.org

I am a developer for a line of multi-port PCI serial cards.  I have received
enough requests that it is time to make the cards work with the 2.6.x
kernels.  I see that serial.c has been deprecated and I am wondering if
anyone can tell me exactly how the serial is supposed to work in the new
kernel?

I have been painfully digging through the linux kernel mailing list archive
in an attempt to glean some insight as to the new serial driver.  But
haven't had much luck.  I am hoping somebody might be able to help me
understand how I can use the new driver (or at least point me where I need
to go).

In the past (2.4.x days) I have just hacked the serial.c code to do what I
needed and then recompiled it as something else.

I would like for someone to explain to me exactly how a guy like me is
"supposed" to use this new driver.  Let's say that I have submitted a patch
to 8250_pci.c that inserts my cards' device and vendor ids and my cards'
.init and .setup routines (if I need them).  Now they can be recognized by
the driver and will initialize correctly as 16550A type ports.  Now I need
to be able to write a few routines that can configure my card's special
features.  In my hijacked serial.c I just added these routines as IOCTL's
and life was good.  How should I "correctly" write these routines for the
new driver?

Thank you,

Remember, please copy the serial list at linux-serial@vger.kernel.org

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com

