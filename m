Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131046AbQKPRfp>; Thu, 16 Nov 2000 12:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbQKPRff>; Thu, 16 Nov 2000 12:35:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:24071 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131046AbQKPRfZ>;
	Thu, 16 Nov 2000 12:35:25 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011161705.UAA03238@ms2.inr.ac.ru>
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: alan@lxorguk.UKuu.ORG.UK (Alan Cox)
Date: Thu, 16 Nov 2000 20:05:05 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E13wRWU-0007yG-00@the-village.bc.nu> from "Alan Cox" at Nov 16, 0 07:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > request_module has the same effect as running suid.  dev_load() can
> > take the interface name and pass it to modprobe unchanged and modprobe
> > does not verify its input, it trusts root/kernel.
> 
> Then dev_load is being called the wrong way. In older kernels we explicitly
> only did a dev_load with user passed names providing suser() was true.

It checks CAP_SYS_MODULE nowadays.

Which does not look good by the way, it is function of request_module(),
rather than of caller.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
