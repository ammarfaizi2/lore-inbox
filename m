Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbULOTMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbULOTMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbULOTJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:09:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42368 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262455AbULOTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:07:57 -0500
Subject: Re: dynamic-hz
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1102983378.9865.11.camel@orbiter>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <41BD483B.1000704@suse.de>  <20041213135820.A24748@flint.arm.linux.org.uk>
	 <1102949565.2687.2.camel@localhost.localdomain>
	 <1102983378.9865.11.camel@orbiter>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103133841.3180.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 18:04:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-14 at 00:16, Eric St-Laurent wrote:
> Alan,
> 
> On a related subject, a few months ago you posted a patch which added a
> nice add_timeout()/timeout_pending() API and converted many (if not
> most) drivers to use it.
> 
> If I remember correctly it did not generate much comments and the work
> was not pushed into mainline.
> 
> I think it's a nice cleanup, IMHO the time_(before|after)(jiffies, ...)
> construct is horrible.
> 
> Any chance to resurrect this work ?

I plan to ressurect it when I have a little time but with some small
additions from the original work. Several people said "it should be mS
not HZ" and someone at OLS proposed that the API also includes an
accuracy guide so that systems using programmed wakeups can aggregate
timers when accuracy doesn't matter.

