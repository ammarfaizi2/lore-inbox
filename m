Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVAQN2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVAQN2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVAQN2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:28:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61831 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262793AbVAQN15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:27:57 -0500
Subject: Re: vgacon fixes to help font restauration in X11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Egbert Eich <eich@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16875.32871.47983.655764@xf14.local>
References: <16867.58009.828782.164427@xf14.fra.suse.de>
	 <1105745463.9839.55.camel@localhost.localdomain>
	 <16875.32871.47983.655764@xf14.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105961582.12709.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 12:23:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 09:07, Egbert Eich wrote:
> Can you point me to these reports?
> I tested with a couple chipsets here and didn't find any problems.

I'll take a dig. The ones I've got are for 2.4 so relate to old code.

> We could check for the kernel version. This could be done during build
> time - assuming we don't ship generic binaries or during run time if we
> want to provide binaries that work everywhere.
> In reality the former would be sufficient for a lot of cases - especially
> for vendor supplied binaries.

The former would be a disaster for Fedora for example - we ship
'current' kernels and having kernel upgrades require a new X11 won't
endear users . A runtime check on version might work I was wondering if
it would be better to have an actual interface that said "do/do not
restore the extra bits in kernel".

That also avoids any suprises and regressions ?

> Anyway, would my patch be acceptable for the kernel?

I'm not video maintainer but other than the detection question it looks
sensible to me.

