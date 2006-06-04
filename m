Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750731AbWFDJqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWFDJqF (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFDJqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:46:05 -0400
Received: from main.gmane.org ([80.91.229.2]:29060 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750731AbWFDJqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:46:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: skge killing off snd_via686 interrupts on Fedora Core 5
Date: Sun, 04 Jun 2006 10:45:46 +0100
Message-ID: <pan.2006.06.04.09.45.33.201398@yahoo.com>
References: <pan.2006.05.27.14.43.20.450376@yahoo.com> <1149181417.12932.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-cwma2-0-0-cust739.swan.cable.ntl.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This accidentally fell off list so I'm going to see if I bodge it back)

On Sat, 03 Jun 2006 10:55:48 +0100, Alan Cox wrote:
> Ar Sad, 2006-06-03 am 21:31 +0100, ysgrifennodd Sitsofe Wheeler:
> > As mentioned in another reply the cards aren't onbord and are a PCI card
> > upgrade.
> 
> Same slot as the card you upgraded from ?

You've got me there. I have no idea - most of the machines had their
network card removed before a clean upgrade from Fedora Core 4 to Fedora
Core 5. I can go and swap an old card back on to the same slot though. On
the one machine that had its card swapped after the upgrade it looks like
ACPI allocated the old and new cards the same IRQ (16). Is there anything
in particular that I'm looking for on the old card (e.g. would showing
/proc/interrupts before and after help)? It might be worth noting that 
IRQ 11 doesn't seem to be disabled when there is anything else going
during the network transfer - e.g. if a video is being watched while the
netperf is being carried out the IRQ isn't disabled. Seemingly the problem
only shows when the card is hitting some sort of top speed...

[netperf showed that there was a performance hit to enabling irqpoll but
there was less of a hit using noapic. Either option cured the problem
and I added the netperf score to the mail]

> > irqpoll
> >  87380  16384  16384    10.00      29.63
> > noapic
> >  87380  16384  16384    10.00      53.21
> 
> That does strongly suggest IRQ routing problems are involved, but it may
> also be timing, hence the question about slots

-- 
Sitsofe | http://sucs.org/~sits/


