Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVIFPFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVIFPFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVIFPFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:05:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60587 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750708AbVIFPFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:05:42 -0400
Date: Tue, 6 Sep 2005 17:05:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: viro@ZenIV.linux.org.uk
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
In-Reply-To: <20050906134944.GV5155@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509061701060.3743@scrub.home>
References: <20050906004842.GP5155@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0509061205510.3743@scrub.home> <20050906134944.GV5155@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:

> We could go for your "allow" form, but what else would need it?  USB gadget
> stuff with its "must have at most one low-level driver, high-level drivers
> should be allowed only if a low-level one is present"?  RTC mess is better
> solved in other ways, PARPORT_PC is mostly solved by now, what's left?
> VGA_CONSOLE?  I really don't see enough uses for such construct...

It would be mostly useful for arm/mips with their millions of 
configurations. Adding or removing one of them would become easier if the 
references to it aren't spread over the complete.
Basically select is already used (and sometimes abused) this way.

bye, Roman
