Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbULNAQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbULNAQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbULNAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:16:18 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:21213 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261355AbULNAQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:16:10 -0500
Subject: Re: dynamic-hz
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1102949565.2687.2.camel@localhost.localdomain>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <41BD483B.1000704@suse.de>  <20041213135820.A24748@flint.arm.linux.org.uk>
	 <1102949565.2687.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 13 Dec 2004 19:16:17 -0500
Message-Id: <1102983378.9865.11.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 14:52 +0000, Alan Cox wrote:

> On a PC it makes huge sense, the deeply embedded folks who do turn the
> thing off for 30secs at a time (Eg cellphone) also want it as do
> virtualisation people where it trashes your scaling. API wise it isn't
> too hard, its just a matter of time to convert the jiffies users away
> and to do relative versions of add_timer with accuracy info included.

Alan,

On a related subject, a few months ago you posted a patch which added a
nice add_timeout()/timeout_pending() API and converted many (if not
most) drivers to use it.

If I remember correctly it did not generate much comments and the work
was not pushed into mainline.

I think it's a nice cleanup, IMHO the time_(before|after)(jiffies, ...)
construct is horrible.

Any chance to resurrect this work ?

PS: the original subject was "Initial bits to help pull jiffies out of
drivers"

Best regards,

Eric St-Laurent


