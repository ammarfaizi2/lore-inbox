Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVIFQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVIFQNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIFQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:13:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16044 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750733AbVIFQNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:13:17 -0400
Date: Tue, 6 Sep 2005 18:13:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: viro@ZenIV.linux.org.uk
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
In-Reply-To: <20050906152320.GX5155@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509061807200.3728@scrub.home>
References: <20050906004842.GP5155@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0509061205510.3743@scrub.home> <20050906134944.GV5155@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0509061701060.3743@scrub.home> <20050906152320.GX5155@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:

> # there's a glue for PC-like FDC
> allow BLD_DEV_FD
> 
> If you insist on having dummy config around allow/select, I don't see any
> real benefits in using "allow" form...

It has to be in some context, otherwise Kconfig can't tell whether it 
belongs to the previous config or stands alone.
At the very last it needs something so it can be internally translated to

config y
	tristate
	allow BLD_DEV_FD

OTOH every arch already defines a "config <arch>", where things like this 
can be added.

bye, Roman
