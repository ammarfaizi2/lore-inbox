Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWBTAgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBTAgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWBTAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:36:46 -0500
Received: from digitalimplant.org ([64.62.235.95]:8663 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751144AbWBTAgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:36:45 -0500
Date: Sun, 19 Feb 2006 16:36:34 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060220002053.GF15608@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
 <20060220000907.GE15608@elf.ucw.cz> <Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
 <20060220002053.GF15608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Pavel Machek wrote:

> On Ne 19-02-06 16:17:01, Patrick Mochel wrote:

> > I really fail to see what your fundamental objection is. This restores
> > compatability, makes the core simpler, and adds the ability to use the
> > additional states, should drivers choose to implement them; all for
> > relatively little code. It seems a like a good thing to me..
>
> Compatibility is already restored.

No, the interface is currently broken. The driver core does not dictate
what values are valid or invalid. It is meant to be used by the bus
drivers to help provide a simiar interface as each other, and to reduce
duplicate code.

It should not be filtering the value. Period. That is a policy decision,
and what is worse, is that it is a static, hard-coded policy decision. The
decision to only accept "0", "2", or "3" is a decision that should be made
on a bus-by-bus basis.

> Introducing additional states should be done in right way, something
> we can keep long-term.

Yup, and it starts with the core not deciding what values are wrong or
right.

Thanks,


	Pat
