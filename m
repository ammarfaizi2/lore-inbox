Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbULFRPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbULFRPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbULFRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:15:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32971 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261572AbULFRP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:15:27 -0500
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041206162153.GH16958@lug-owl.de>
References: <87acsrqval.fsf@coraid.com>  <20041206162153.GH16958@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102349517.14472.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 16:11:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-06 at 16:21, Jan-Benedict Glaw wrote:
> > Like IP, AoE is an ethernet-level network protocol, registered with
> > the IEEE.  Unlike IP, AoE is not routable.
> 
> So AoE is out of scope for many uses...

Take a look at their product range and you'll see the intended uses. For
those I'm not sure routability actually matters too much. In addition
you'd want to tunnel it on a shared LAN to add crypto.

> > +	n = lhget32(p+4);
> > +	n <<= 32;
> > +	return n |= lhget32(p);
> > +}
> 
> There are function available for this, look at the endianess header
> files.

Ed:
cpu_to_le32() and friends to be more exact. These also have the
advantage they've been optimised and are asm on some systems.

> After all, especially keeping in mind that AoE isn't routeable, my
> thinking is that this had better written as a (E)NBD server process
> running in userspace. This way, you'd use the in-kernel NBD driver (or
> the ENBD which isn't in the kernel) and you the the routing stuff for
> free :)

Different problem space IMHO.

