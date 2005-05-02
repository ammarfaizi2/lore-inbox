Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVEBOQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEBOQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEBOQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:16:52 -0400
Received: from yupa.krose.org ([66.92.73.159]:16114 "EHLO
	chihiro.valley-of-wind.krose.org") by vger.kernel.org with ESMTP
	id S261263AbVEBOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:16:48 -0400
Message-ID: <4276362A.8090508@krose.org>
Date: Mon, 02 May 2005 10:16:10 -0400
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Kyle Rose <krose+linux-kernel@krose.org>, linux-kernel@vger.kernel.org
Subject: Re: ACPI sleep states on Tyan Thunder K8W S2885
References: <42726287.80104@krose.org> <20050501225335.GG3951@neo.rr.com>
In-Reply-To: <20050501225335.GG3951@neo.rr.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> S5 wake devices can be a very fuzzy area.  In general, the ACPI spec
> recommends that wake capabilities are enabled before halting the system.
> Therefore, your network card driver may need to specifically handle this.

I'll check into that.

> For starters, we should probably look at "lspci -vv".  I'm assuming your
> network card is PCI.  This will allow us to see if it's capable of waking
> from D3-cold, the state it will most likely be in during S5.

I'll have to do this tonight.  I can't start the machine remotely. :)

> I would also check your BIOS configuration and see if it's possible to
> specifically enable wake-on-lan.  Let me know if this helps.

It only has an option for "wake on PME," which I've activated.  Again,
as I've said, shutting down from Win XP allows WOL, so the difference is
between how Linux and Windows handle the GigE device or handle shutdown.

> Finally, what kernel version are you using?

Sorry, I should have given more details.  It's Linux-2.6.11.7 with no
other patches.  I think the earliest I tested this was with 2.6.9, and
it didn't work there either.

Thanks,
Kyle
