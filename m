Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUEVBVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUEVBVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUEVBS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:18:28 -0400
Received: from not.theboonies.us ([66.139.79.224]:14027 "EHLO
	not.theboonies.us") by vger.kernel.org with ESMTP id S264798AbUEVBPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:15:47 -0400
Message-ID: <1085002775.40abd417121b0@mail.theboonies.us>
Date: Wed, 19 May 2004 16:39:35 -0500
To: James Simmons <jsimmons@infradead.org>
Cc: akpm@osdl.org,
       Linux Frame Buffer Dev 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] FB accel capabilities patch
References: <Pine.LNX.4.44.0405192026290.28783-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0405192026290.28783-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.3
X-Originating-IP: 213.197.71.87
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: David Eger <eger@theboonies.us>
X-Primary-Address: random@theboonies.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Simmons <jsimmons@infradead.org>:

> > +/* FBIF = FB_Info.Flags */
> > +#define FBIF_MODULE		0x0001	/* Low-level driver is a module */
>
> Ug. You changed that. Could that remain the same.

Will it suffice to add

#define FBINFO_FLAG_MODULE FBIF_MODULE

for backwards compatibility?

I'd prefer the new flags to be FBIF_*, as the identifier
FBINFO_FLAG_HWACCEL_COPYAREA seems sorta long to me...

I'll sync with linus's bk tomorrow and try to rework my main patch; the
"mainline" patch I posted was against his bk shortly after 2.6.6...

> I have a patch coming that fixes the mode setting. It changes alot of the
> core fbcon.c so I will apply your patch to the fbdev-2.5 tree.

I take it this is in addition to your con2fb patch I have posted at that web
address?

-dte
