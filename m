Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTFVL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbTFVL2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:28:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43212
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264888AbTFVL2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:28:14 -0400
Subject: Re: [patch] SiS IRQ router 96x detection (2.5.69) ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "'Thomas Winischhofer'" <twini@xfree86.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <00b201c33897$e36378b0$2101a8c0@witbe>
References: <00b201c33897$e36378b0$2101a8c0@witbe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056282008.2070.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2003 12:40:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-22 at 09:25, Paul Rolland wrote:
> Hello,
> 
> > didn't work. I did spend a few hours on the patch and I was willing to
> > spend another one to see the kernel fixed. But if he does not 
> > care, why
> > should I ?
> 
> Maybe because some others *do* appreciate the work you did, and the
> patch being available...

Don't get me wrong - I am glad he's done a lot of detective work on this
and on other stuff. That isn't the only problem however - we have cases
where there are entire ranges of PCI idents that have one driver and
others requiring more care that we dont handle well right now either (eg
440GX).

Another problem is that the table entries get used which means the
table itself cannot be __init.

That makes me wonder if we should in fact have a set of detect functions
that fill in a struct irq_router * and remove most of the array while fixing
the other stuff. That cleans up the detect, removes the 440GX ifdefs properly
with some care, removes the 440GX bios dmi table entries, and fixes SiS.

It isnt that Davide's patch makes it too ugly, its already too ugly, Davide and
also 440GX just hit the places that make it rather obvious it wants a proper
clean up

Alan

