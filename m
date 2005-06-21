Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVFUUZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVFUUZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVFUUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:23:03 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:8138 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262311AbVFUUUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:20:55 -0400
Date: Tue, 21 Jun 2005 13:20:37 -0700
From: Tony Lindgren <tony@atomide.com>
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Juergen Brunk <Juergen.Brunk@eurolog.com>, johan.heikkila@netikka.fi,
       Tarmo Jarvalt <tarmo.jarvalt@mail.ee>,
       Johnathan Hicks <thetech@folkwolf.net>
Subject: Re: [PATCH 2.6.12] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050621202035.GE31391@atomide.com>
References: <20050620205334.GA28230@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620205334.GA28230@sommrey.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joerg Sommrey <jo@sommrey.de> [050620 13:54]:
> This is a processor idle module for AMD SMP 760MP(X) based systems.
> The patch was originally written by Tony Lindgren and has been around
> since 2002.  It enables C2 mode on AMD SMP systems and thus saves
> about 70 - 90 W of energy in the idle mode compared to the default idle
> mode.  The idle function has been rewritten and now should be free of
> locking issues and is independent from the number of CPUs.  The impact
> from this module on the system clock has been reduced. 
> 
> This patch can also be found at
> http://www.sommrey.de/amd76x_pm/amd_76x_pm-2.6.12-jo1.patch

Cool. Just once comment:

> +// #define AMD76X_NTH 1
> +// #define AMD76X_POS 1
> +// #define AMD76X_C3 1

How about separating all this ifdef code into a separate debug patch on top
of the amd_76x_pm patch? Or just leave it out as I don't think anybody is
using it. It would shrink down the patch quite a bit and make it more
readable.

I won't be able to access my dual athlon box until September, so I'm not
much of help with this module :)

Regards,

Tony
