Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWAKVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWAKVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAKVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:54:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:8660 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750759AbWAKVy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:54:27 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060111214351.GF6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	 <20060111212056.GC6617@hansmi.ch>
	 <1137015258.5138.20.camel@localhost.localdomain>
	 <20060111213805.GE6617@hansmi.ch>
	 <1137015669.5138.22.camel@localhost.localdomain>
	 <20060111214351.GF6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:54:09 +1100
Message-Id: <1137016449.5138.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 22:43 +0100, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 08:41:08AM +1100, Benjamin Herrenschmidt wrote:
> > > Johannes Berg told me he wants to use the fn key alone to switch the
> > > keyboard layout or something. For such uses, the pb_enablefn is there.
> 
> Sorry, actually it's called pb_disablefn now.
> 
> > What does it do ? Just send a keycode ? That should be unconditionnal.
> > The Fn key should change a keycode always. I don't see why you would
> > that to be off.
> 
> No, if that parameter is disabled, it translates key combinations like
> Fn+F1 to KEY_BRIGHTNESSUP. If it's enabled, it only sends KEY_FN.

But that should be the full translation no ? I don't see why you are
splitting in translating the special keys and translating the rest of
the keyboard...

Ben.


