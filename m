Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPSy0>; Thu, 16 Nov 2000 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKPSyQ>; Thu, 16 Nov 2000 13:54:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129069AbQKPSyJ>; Thu, 16 Nov 2000 13:54:09 -0500
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: kuznet@ms2.inr.ac.ru
Date: Thu, 16 Nov 2000 18:24:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200011161732.UAA03398@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Nov 16, 2000 08:32:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wThz-0008C0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is the first. And the second: each user is allowed to refer to this device.
> And it is problem of module to allow to load corresponding module or not
> to allow this.

Not so.

> It means that test for CAP_SYS_MODULE is illegal, moving pure policy
> issue to improper place.

Definitely not so

What matters is whether the user is requesting a module or the kernel is 
choosing to load a module. In the former case where the user can influence the
module name then you need to check CAP_SYS_MODULE in the latter you do not
care.

Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
