Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRLLWc5>; Wed, 12 Dec 2001 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRLLWcq>; Wed, 12 Dec 2001 17:32:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282707AbRLLWce>; Wed, 12 Dec 2001 17:32:34 -0500
Subject: Re: USB not processing APM suspend event properly?
To: jdthood@mail.com (Thomas Hood)
Date: Wed, 12 Dec 2001 22:41:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1008195310.1126.17.camel@thanatos> from "Thomas Hood" at Dec 12, 2001 05:15:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EI4D-0002h7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my USB mouse, but then tried (twice) to reconnect it again
> while the apm driver was still processing the suspend.  The
> attempts to reconnect failed.  I presume there is something
> wrong with this picture.  Does this indicate a bug in
> USB power management?

More it indicates a bug in the APM code. Have a look at Russell King's
patches which actually issue the APM and user mode events in the right
order. There is a USB problem there too, but the USB problem can't be fixed
sanely until the APM order is fixed
