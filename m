Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129649AbRBHTc3>; Thu, 8 Feb 2001 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130502AbRBHTcT>; Thu, 8 Feb 2001 14:32:19 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:5128 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129649AbRBHTcN>;
	Thu, 8 Feb 2001 14:32:13 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102081931.WAA23500@ms2.inr.ac.ru>
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
To: jdthoodREMOVETHIS@yahoo.co.UK (Thomas Hood)
Date: Thu, 8 Feb 2001 22:31:33 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A81EC74.8E4D9B7F@yahoo.co.uk> from "Thomas Hood" at Feb 8, 1 04:15:02 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Here is a patch which may not solve the underlying

This does not. refcnt cannot be <1 at this point.


> assuming that the latter messages aren't serious?

They are fatal. Machine must be rebooted after them.


> I hope the networking gurus can find the real bugs here.

Well, someone forgets to grab refcnt or makes redundant dev_put.
Try to catch this, f.e. adding BUG() to the places where fatal
messages are generated to get backtraces.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
