Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbSJCMLs>; Thu, 3 Oct 2002 08:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263258AbSJCMLr>; Thu, 3 Oct 2002 08:11:47 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:22546 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S263251AbSJCMLr>; Thu, 3 Oct 2002 08:11:47 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pr e8)
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A79D1@EXCHANGE>
To: Ed Vance <EdV@macrolink.com>
Date: Thu, 3 Oct 2002 14:16:53 +0200 (CEST)
CC: "'Russell King'" <rmk@arm.linux.org.uk>,
       Marek Michalkiewicz <marekm@amelek.gda.pl>,
       linux-kernel@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17x4uT-0008Au-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree. For 2.4, Stability before elegance. Minimum change is a good thing.
> The patch looks straight-forward enough, simply plop the file into a
> directory for which it was never intended. It does localize the effect of
> the change nicely. 

Yes, moving parport_serial looked much simpler to me than moving serial
to its own directory (the proper solution, done in 2.5).  I hope others
can also agree to accept this low risk change for 2.4 in the meantime.

In some sense, parport_serial is not strictly part of neither serial nor
parport drivers - it is common to (uses the services of) both.

> I have a question. Similar changes have been suggested several times and
> always seem to bring out a small hail of rather negative comments. (like
> "gross hack ..." :) 

Well, the hardware itself is kind of a hack (not a clean design - no
separate PCI functions for serial and parallel ports; I guess that would
use a little more silicon and make the chip a few cents more expensive),
and that's the reason why the parport_serial driver exists at all...

Thanks,
Marek

