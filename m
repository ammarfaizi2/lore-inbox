Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274897AbTHKTh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273345AbTHKTfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:35:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36055 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S273403AbTHKTel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:34:41 -0400
Date: Mon, 11 Aug 2003 21:34:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Johannes Stezenbach <js@convergence.de>,
       Gerd Knorr <kraxel@bytesex.org>,
       Flameeyes <dgp85@users.sourceforge.net>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811193401.GA8957@ucw.cz>
References: <1060616931.8472.22.camel@defiant.flameeyes> <20030811163913.GA16568@bytesex.org> <20030811175642.GC2053@convergence.de> <20030811185947.GA8549@ucw.cz> <20030811191709.GN2627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811191709.GN2627@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 09:17:10PM +0200, Pavel Machek wrote:

> > > > > We can drop /dev/lirc*, and use input events with received codes, but I
> > > > > think that lircd is still needed to translate them into userland
> > > > > commands...
> > > > 
> > > > That translation isn't done by lircd, but by the lirc_client library.
> > > > This is no reason for keeping lircd as event dispatcher, the input layer
> > > > would do equally well (with liblirc_client picking up events from
> > > > /dev/input/event<x> instead of lircd).
> > > 
> > > IMHO there's one problem:
> > > 
> > > If a remote control has e.g. a "1" key this doesn't mean that a user
> > > wants a "1" to be written into your editor while editing source code.
> > > The "1" key on a remote control simply has a differnt _meaning_ than
> > > the "1" key on your keyboard -- depending of course on what the user
> > > thinks this key should mean.
> > 
> > That's what BTN_1 is for. ;)
> 
> Ahha, I thought BTN_1 would be first mouse button ;-). Will fix that.

No, that'd be BTN_LEFT.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
