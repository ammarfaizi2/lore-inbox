Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWKJQ4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWKJQ4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161876AbWKJQ4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:56:52 -0500
Received: from www.osadl.org ([213.239.205.134]:11430 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161354AbWKJQ4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:56:52 -0500
Subject: Re: 2.6.19-rc5-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00611100829m5fbd32cdt14c307e492df2984@mail.gmail.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <40f323d00611100829m5fbd32cdt14c307e492df2984@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 17:59:12 +0100
Message-Id: <1163177952.8335.221.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 17:29 +0100, Benoit Boissinot wrote:
> On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
> > [snip]
> > - The hrtimer+dynticks code still doesn't work right for machines which halt
> >   their TSC in low-power states.
> >
> 
> With CONFIG_NO_HZ=y, xmoto (xmoto.sf.net, a 3d game) is sluggish, the
> movement is not fluid (it is "bursty").
> 
> .config is at http://perso.ens-lyon.fr/benoit.boissinot/kernel/config-2.6.19-rc5-mm1
> lspci -vv: http://perso.ens-lyon.fr/benoit.boissinot/kernel/docked_lspci
> dmesg: http://perso.ens-lyon.fr/benoit.boissinot/kernel/dmesg-2.6.19-rc5-mm1

I'm confused about that one:

[    8.966364] Disabling NO_HZ and high resolution timers due to timer broadcasting (C3 stops local apic)

This message is nowhere in rc5-mm1. It was in rc4-mmX, but got removed
in the updates.

> I can test any patch or provide any needed information.

http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff

That's the rework I did yesterday.

	tglx


