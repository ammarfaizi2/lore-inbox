Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWAKVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWAKVrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWAKVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:47:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:10126 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750935AbWAKVrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:47:13 -0500
Date: Wed, 11 Jan 2006 22:47:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111214732.GA12014@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com> <20060111212056.GC6617@hansmi.ch> <1137015258.5138.20.camel@localhost.localdomain> <20060111213805.GE6617@hansmi.ch> <1137015669.5138.22.camel@localhost.localdomain> <20060111214351.GF6617@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111214351.GF6617@hansmi.ch>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:43:51PM +0100, Michael Hanselmann wrote:

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
 
I believe a better behavior would be to send KEY_FN and then
KEY_BRIGHTNESSUP when enabled and KEY_FN and KEY_F1 when disabled.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
