Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTAETB5>; Sun, 5 Jan 2003 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTAETB5>; Sun, 5 Jan 2003 14:01:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264992AbTAETB4>; Sun, 5 Jan 2003 14:01:56 -0500
Date: Sun, 5 Jan 2003 11:05:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, <pazke@orbita1.ru>, <anton@samba.org>
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
In-Reply-To: <1041756963.645.43.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0301051103030.11848-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Jan 2003, Benjamin Herrenschmidt wrote:
> 
> Note that if we go the full way abstracting interrupts, then the
> interrupt "tree" should be separate from the device tree. The interrupt
> "parent" of a device may not be (and is not in a whole lot of cases I
> have to deal with on pmacs and embedded) the "bus" parent of a given
> device.

I disagree. The pmac braindamage is a pmac problem, and not worth 
uglifying the generic device layer over. Besides, as far as I know, it is 
trivially solved by just making the pmac irq controller be a root 
controller, and that's it. There are no other irq controllers there that 
are worth worrying about.

> Do you think this is still 2.5 work ?

No.

		Linus

