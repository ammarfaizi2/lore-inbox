Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130052AbQJaVGt>; Tue, 31 Oct 2000 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQJaVGj>; Tue, 31 Oct 2000 16:06:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130517AbQJaVGY>; Tue, 31 Oct 2000 16:06:24 -0500
Subject: Re: Hardware APM suspend
To: compwiz@bigfoot.com (Ari Pollak)
Date: Tue, 31 Oct 2000 21:07:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001031160037.A11639@darth.ns> from "Ari Pollak" at Oct 31, 2000 04:00:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qidA-0008Gm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Question - is hardware APM suspend supported in any current available
> kernel/apmd? I ask this because when I press the power button on my
> computer, which is supposed to do a hardware suspend (according to my
> BIOS) and I'm in X, the screen basically turns to garbage and I can't do
> anything except reset/poweroff my computer.

It is the job of the APM BIOS to correctly restore the display. Needless to
say since the average BIOS writer has trouble with simple int calls they don't
have a chance here, especially non laptop.

XFree 4.0 apparently has some APM awareness and may help. If not then the apmd
user stuff has helpful aids that worked for me on some Dell horror I borrowed

On Red Hat you can edit /etc/sysconfig/apmd and add

CHANGEVT=1

this will set the apmd scripts up to switch back to the text console on
suspend.

ALan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
