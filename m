Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTHEUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbTHEUZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:19847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270641AbTHEUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:25:24 -0400
Date: Tue, 5 Aug 2003 13:25:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andi Kleen <ak@colin2.muc.de>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export touch_nmi_watchdog
In-Reply-To: <1060114808.5308.9.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0308051324070.2587-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Aug 2003, Arjan van de Ven wrote:
> 
> having a more generic/portable "trigger_watchdog" function would be
> better then, such that ALL watchdogs, and not just the NMI one can hook
> into this

Why are we working around broken drivers?

I say:
 - either fix the driver
or
 - disable the watchdog entirely.

I don't see any point at all to touch_xxx_watchdog() from a driver.

		Linus

