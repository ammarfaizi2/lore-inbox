Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268988AbRG3Ptt>; Mon, 30 Jul 2001 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbRG3Ptj>; Mon, 30 Jul 2001 11:49:39 -0400
Received: from [64.7.140.42] ([64.7.140.42]:52733 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S268985AbRG3Pt3>;
	Mon, 30 Jul 2001 11:49:29 -0400
Message-ID: <035001c1190f$c6b46700$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "christophe =?ISO-8859-1?Q?barb=E9" ?= <christophe.barbe@lineo.fr>,
        "James Bottomley" <James.Bottomley@steeleye.com>
Cc: "christophe =?ISO-8859-1?Q?barb=E9" ?= <christophe.barbe@lineo.fr>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain> <20010730173702.C19605@pc8.lineo.fr>
Subject: Re: serial console and kernel 2.4
Date: Mon, 30 Jul 2001 11:53:28 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "christophe barbé" <christophe.barbe@lineo.fr>
> "it works for me" is better that no answer for me. So Thank you for your
> answer.
> Reto give me a solution : because of a flag all incomming char are
ignored.
> So now I need to find why this flag is ok for you and not for me.

The patch breaks the correct operation of the serial driver.
CREAD is the flag that enables/disables the rx side of the serial
port. The kernel or whatever service is trying to use the console
doesn't set CREAD, so rxed (incoming) characters are ignored.

You need to find out why the CREAD handling isn't done properly.
This has come up a number of times on lkml recently; you should
be able to find an appropriate answer or pointer in the right
direction by checking the archives.

Patching the driver breaks the driver instead of fixing the problem.

..Stu


