Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286941AbRL1Rek>; Fri, 28 Dec 2001 12:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbRL1ReX>; Fri, 28 Dec 2001 12:34:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12810 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286937AbRL1ReI>; Fri, 28 Dec 2001 12:34:08 -0500
Subject: Re: 2.4.17 absurd number of context switches
To: davidel@xmailserver.org (Davide Libenzi)
Date: Fri, 28 Dec 2001 17:43:46 +0000 (GMT)
Cc: skraw@ithnet.com (Stephan von Krawczynski),
        alan@lxorguk.ukuu.org.uk (Alan Cox), jwb@saturn5.com,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.40.0112280920270.1466-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 28, 2001 09:22:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K12o-0001BR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         local_irq_disable();
>         if (current->counter > 0)
>             --current->counter;
>         local_irq_enable();

Umm: SuS sayeth..

   DESCRIPTION

     The sched_yield() function forces the running thread to relinquish the
     processor until it again becomes the head of its thread list. It takes
     no arguments.

Which doesnt seem to be what you are doing.
