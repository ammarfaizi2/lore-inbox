Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbRFKU6H>; Mon, 11 Jun 2001 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264038AbRFKU55>; Mon, 11 Jun 2001 16:57:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264035AbRFKU5w>; Mon, 11 Jun 2001 16:57:52 -0400
Subject: Re: softirq bugs in pre2
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 11 Jun 2001 21:55:49 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.31.0106111207350.4452-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 11, 2001 12:09:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159Yiz-0000MA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The copy-user latency fixes only make sense for out-of-line copies. If
> we're going to have a conditional function call to "schedule()", we do not
> want to inline the dang thing any more - we've just destroyed our register
> set etc anyway.

Is there any reason we still inline so many copy_* and put/get user calls. I
can't benchmark a difference out of line and the code shrinkage is more
than measurable (AMD Athlon 550 and AMD Athlon 1GHz)
