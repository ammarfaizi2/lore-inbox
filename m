Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDAVtr>; Sun, 1 Apr 2001 17:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDAVth>; Sun, 1 Apr 2001 17:49:37 -0400
Received: from colorfullife.com ([216.156.138.34]:39430 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132570AbRDAVtY>;
	Sun, 1 Apr 2001 17:49:24 -0400
Message-ID: <004601c0baf5$8fac4700$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010401160430.28121K-100000@mandrakesoft.mandrakesoft.com>
Subject: Re: bug database braindump from the kernel summit
Date: Sun, 1 Apr 2001 23:48:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
>
> /proc/pci data alone with every bug report is usually invaluable.

Even if the bug is a compile error?

E.g.
BUG REPORT (a real one, I didn't have the time yet to post a patch):
kernel versions: tested with 2.4.2-ac24, afaics 2.4.3 is also affected
Description:
Several config options are missing in the 'if' at the end of
linux/drivers/net/pcmcia/Config.in.
This means that CONFIG_PCMCIA_NETCARD is not set, and then (iirc) the
kernel won't link.

CONFIG_ARCNET_COM20020_CS
CONFIG_PCMCIA_HERMES
CONFIG_AIRONET4500_CS
CONFIG_PCMCIA_IBMTR
are missing.

Obviously too much data doesn't hurt, as long as
* it's hidden somewhere deep in a database, clearly separated from the
important parts (if there is an oops: decoded oops, description, how
easy is it to trigger the bug, steps to reproduce)
* very easy for the bug reporter to collect.
* not mandatory.

--
    Manfred

