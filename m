Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbQKPSCx>; Thu, 16 Nov 2000 13:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130879AbQKPSCn>; Thu, 16 Nov 2000 13:02:43 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:37127 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130336AbQKPSCb>;
	Thu, 16 Nov 2000 13:02:31 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011161732.UAA03398@ms2.inr.ac.ru>
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 16 Nov 2000 20:32:19 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E13wShQ-000860-00@the-village.bc.nu> from "Alan Cox" at Nov 16, 0 05:19:45 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Only the caller knows if the data is tainted. Thus only the caller can decide

Sorry? What data? What to decide?

Device name of &|&|&|&|&|& is absolutely legal, nicely loking name.
dev.c _wants_ to load such device and it is problem of kmod,
if it is not able to make this.

It is the first. And the second: each user is allowed to refer to this device.
And it is problem of module to allow to load corresponding module or not
to allow this.

It means that test for CAP_SYS_MODULE is illegal, moving pure policy
issue to improper place.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
