Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHDCyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHDCyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUHDCyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:54:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:12707 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266129AbUHDCx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:53:58 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091586381.3189.14.camel@laptop.cunninghams>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
Content-Type: text/plain
Message-Id: <1091587985.5226.74.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 12:53:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've also done partial-tree support for suspend2 by making a new list
> (along side the active, off and off_irq lists) and simply moving devices
> I want to keep on (plus their parents) to this list prior to calling
> device_suspend. Works well for keeping alive the ide devices being used
> write the image.

How so ? By not calling suspend for it at all ? That's broken, the
driver wants suspend to match the resume it will get when the image
is reloaded, that's the only way the driver can guarantee a sane state
saved in the suspend image.

Ben.


