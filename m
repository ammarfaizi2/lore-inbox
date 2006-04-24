Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDXM3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDXM3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWDXM3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:29:14 -0400
Received: from hermes.drzeus.cx ([193.12.253.7]:57581 "EHLO mail.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750739AbWDXM3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:29:14 -0400
Message-ID: <444CC4A3.3040309@drzeus.cx>
Date: Mon, 24 Apr 2006 14:29:23 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Jani-Matti_H=E4tinen?=" <jani-matti.hatinen@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com>
In-Reply-To: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani-Matti Hätinen wrote:
>         Hello,
> 
> For some reason I haven't been able to access sdhci-devel at drzeus.cx
> for a week now, so sending this here.
> 

I see nothing in the logs from you so I suspect it's in your end. Other
mail coming from pproxy.gmail.com (which is where you seem to be coming
from) are coming through fine.

> I get a hard lock-up every single time, if I do modprobe sdhci after
> waking up from suspend-to-ram. If I compile the module into the kernel
> (or if I don't rmmod it before suspending), I get a lock-up either
> when going to suspend (if there's a card in the reader) or during
> resume (if the reader is empty). With a fresh boot-up the driver works
> just fine. The problem occurs only after the machine has been
> suspended at least once.
>   I've tested this with 2.6.15-gentoo-r1 with the sdhci-0.11 patches
> and vanilla 2.6.17-rc2. Sadly nothing gets as far as to the log when
> the lock-up occurs.

The kernel will not write anything to disk once a panic has occurred. To
see what's going wrong need to be in text mode (framebuffer is not
sufficient) when you do the modprobe.

Rgds
Pierre

