Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLXN03>; Sun, 24 Dec 2000 08:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbQLXN0T>; Sun, 24 Dec 2000 08:26:19 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:27659 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129585AbQLXN0G>; Sun, 24 Dec 2000 08:26:06 -0500
Date: 24 Dec 2000 11:36:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <7sSHLPCmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>
Subject: Re: About Celeron processor memory barrier problem
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 23.12.00 in <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>:

> On Thu, 23 Dec 1999, michael chen wrote:
> >         I found that when I compiled the 2.4 kernel with the option
> >     of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
> >     system hang at very beginning boot stage, and I found the problem
> >     is cause by the fact that Intel Celeron doesn't have a real memory
> >     barrier,but when you choose the Pentium III option, the kernel
> >     assume the processor has a real memory barrier.
> >     Here is a patch to fix it:
>
> No.
>
> The fix is to not lie to the configurator.
>
> A Celeron isn't a PIII, and you shouldn't tell the configure that it is.
>
> The whole point of being able to choose the CPU to optimize for is that we
> can optimize things at compile-time.

Which is all fine, but maybe the kernel really ought to detect that  
problem and complain at boot time?

Or does that happen already?

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
