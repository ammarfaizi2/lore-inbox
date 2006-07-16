Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWGPGRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWGPGRE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 02:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGPGRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 02:17:03 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:28320 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750751AbWGPGRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 02:17:02 -0400
Date: Sun, 16 Jul 2006 08:17:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: 7eggert@gmx.de, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tighten ATA kconfig dependancies
Message-ID: <20060716061706.GB29733@mars.ravnborg.org>
References: <6yL2J-7rR-1@gated-at.bofh.it> <6yLco-7DB-1@gated-at.bofh.it> <E1G1p1y-0000ZU-Io@be1.lrz> <20060716055857.GA29733@mars.ravnborg.org> <1153029887.3033.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153029887.3033.7.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 08:04:47AM +0200, Arjan van de Ven wrote:
> 
> > A cross compile toolchain is the only real soluion. Otherwise we would
> > soon end up with far to many drivers selectable for x84-64.
> 
> if the *driver* is not platform specific, what is the problem with that?
and
> The only difference between x86 and x86-64 is isa-bus
> cards and things that were put on a motherboard but never on a PCI card.
and
> That's maybe a dozen or two total for the entire kernel, and a set that
> is not growing.
By that definition there are still a lot of candidates out-side the IDE
world. The x86 versus x86-64 is irrelevant here. The point is that
kconfig is used to select only relevant options for any given
architecture and with the above definition we could simply boil it down
to "make only what cannot compile for an arch non-selectable".

We have a nice kconfig system that is extensively used to secure we have
a valid kernel configuration all the time and we go long to secure this.
Should we now start to breake that apart to start to give drivers more
compile coverage just becasue that's a tad easier. That brakes the
fundamental of the kconfig in the first place namely to secure valid
configurations.

It is nto the IDE patch as such that is the topic here. It is the
general issue if kconfig at all shall allow one to select drivers that
is not suitable for your HW. Tomorrow it will be a bunch of ARM
drivers..

	Sam
