Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272914AbTHKRjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272867AbTHKRhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:37:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:51916 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S272840AbTHKRfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:35:32 -0400
Date: Mon, 11 Aug 2003 19:35:11 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Flameeyes <daps_mls@libero.it>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811173511.GB2053@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Pavel Machek <pavel@suse.cz>, Flameeyes <daps_mls@libero.it>,
	Christoph Bartelmus <columbus@hit.handshake.de>,
	LIRC list <lirc-list@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <1060607466.5035.8.camel@defiant.flameeyes> <20030811153821.GC2627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811153821.GC2627@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> > a) hardcode all the possible remotes adding these as new one come up,
> > this is a big work in the kernel source, and also we lost compatibility
> > with remotes that use the same frequency of the ones with the tv card,
> > and that now can be used.
> 
> I guess a) is okay. There are not *so* many remote controls out there.

That's not true, unless you just count the remotes that come packaged
with the TV cards. But you might be able to buy all-in-one type
remote controls which work with the TV card's IR receiver (it's also
possible to connect a different IR-sensor to the TV card's IR input).
It would be nice to be able to configure the keys then.

drivers/media/dvb/ttpci/av7110_ir.c does it this way (default map
for Hauppauge, loadable keymaps in linuxtv.org CVS).

Johannes
