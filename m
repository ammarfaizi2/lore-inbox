Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVHAXsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVHAXsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVHAXsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:48:54 -0400
Received: from digitalimplant.org ([64.62.235.95]:22410 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261364AbVHAXsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:48:54 -0400
Date: Mon, 1 Aug 2005 16:48:43 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: pavel@ucw.cz, "" <linux-kernel@vger.kernel.org>
Subject: Re: dpm_runtime_suspend and _resume()
In-Reply-To: <20050730142502.GA4065@isilmar.linta.de>
Message-ID: <Pine.LNX.4.50.0508011644390.2764-100000@monsoon.he.net>
References: <20050730142502.GA4065@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Jul 2005, Dominik Brodowski wrote:

> dpm_runtime_suspend and _resume() would be quite useful for some PCMCIA
> tasks. However, they are only exported in drivers/base/power/power.h. Any
> objection to moving it to include/linux/pm.h ? Any plans to break the
> functionality these functions provide?

Break them anymore than they currently are?

I wouldn't recommend using those functions. We're in the process of
redeveloping the Runtime PM infrastructure and would hate to break users
of existing poorly-designed infrastructure in the process.

I'm curious what your usage model would be. After a certain amount of
time of inactivity, I suspect that you want to power down a PCMCIA slot,
right? Do you already have patches that do that? Is there any problem with
calling the necessary functions directly?

Thanks,


	Pat
