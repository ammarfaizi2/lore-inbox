Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSDIPCl>; Tue, 9 Apr 2002 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDIPCk>; Tue, 9 Apr 2002 11:02:40 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:48903 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S292857AbSDIPCk>;
	Tue, 9 Apr 2002 11:02:40 -0400
Date: Tue, 9 Apr 2002 11:02:37 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Corey Minyard <minyard@acm.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.44.0204091344420.32054-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0204091057540.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Apr 2002, Zwane Mwaikambo wrote:

> Did you forget return values? Or perhaps just redeclare those...
> Also i don't quite understand the new status reporting you're doing, mind
> just explaining it to me a bit? The previous code would tell you wether
> the watchdog is enabled/disabled so you can tell wether the timeout period
> has passed.

Oops, yea, I forgot return values.  I'll fix that up.  I got rid of
sc1200wdt_status because it returns bit 1, which is defined as WDIOF_OVERHEAT
I suppose it would be possible to return WDIOF_KEEPALIVEPING instead.
So something like if(ret & 0x01) return WDIOF_KEEPALIVEPING;?

Regards,
Rob Radez

