Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbQKCTiV>; Fri, 3 Nov 2000 14:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbQKCTiL>; Fri, 3 Nov 2000 14:38:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:36102 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131447AbQKCTiC>;
	Fri, 3 Nov 2000 14:38:02 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011031937.WAA10753@ms2.inr.ac.ru>
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: ak@suse.de (Andi Kleen)
Date: Fri, 3 Nov 2000 22:37:45 +0300 (MSK)
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> from "Andi Kleen" at Nov 3, 0 08:29:11 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> that does hardware register access without protecting against interrupts
> or checking if the interface is up.

This issue is not that issue. It is separate issue and in fact
it is private problem of driver and its author, what is safe,
what is not safe.

F.e. I see no cathastrophe even if MII registers are accessed without
any protections. Diag utilities do this from user space. 8)8)


> de4x5 is probably also buggy in regard to this.

de4x5 is hopeless. I added nice comment in softnet to it.
Unfortunately it was lost. 8)

Andi, neither you nor me nor Alan nor anyone are able to audit
all this unnevessarily overcomplicated code. It was buggy, is buggy
and will be buggy. It is inavoidable, as soon as you have hundreds
of drivers.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
