Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUXZq>; Wed, 21 Feb 2001 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRBUXZg>; Wed, 21 Feb 2001 18:25:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129181AbRBUXZV>; Wed, 21 Feb 2001 18:25:21 -0500
Subject: Re: mke2fs + 8MB + 2.2.5 = hangs
To: javiroman@wanadoo.es (Javi Roman)
Date: Wed, 21 Feb 2001 23:28:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A944C92.60A1E514@wanadoo.es> from "Javi Roman" at Feb 22, 2001 12:17:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vigc-00030Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have not probed a higer kernel because I have any
> compiled drivers (I have not sources) for 2.2.5-15 kernel.
> I don't know if it's a kernel problem or a install program problem.
> (I have a 4MB machine with RedHat 6.2 with 2.2.5-15
> kernel and mk2efs work fine with partition over 100MB???)
> I don't understand.

The RH installer probably still had the workarounds in it that it had for
the 6.0 release. Early 2.2 tended to stop if it was totally idle, had a lot
in ram (or very little ram) and did a lot of writes mkfs style. It almost
only happens on install tools.

That was fixed during mid 2.2 I forget exactly where. There are still 2.2 
open questions with currnet 2.2 but only when creating _very_ large file
systems with little memory, where the write throttling may still need a bit
of work.

Alan

