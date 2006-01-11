Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWAKVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWAKVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWAKVlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:41:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:48851 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750827AbWAKVlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:41:24 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060111213805.GE6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	 <20060111212056.GC6617@hansmi.ch>
	 <1137015258.5138.20.camel@localhost.localdomain>
	 <20060111213805.GE6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:41:08 +1100
Message-Id: <1137015669.5138.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 22:38 +0100, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 08:34:17AM +1100, Benjamin Herrenschmidt wrote:
> > Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
> > have any case where people actually change the other ones ?
> 
> Johannes Berg told me he wants to use the fn key alone to switch the
> keyboard layout or something. For such uses, the pb_enablefn is there.

What does it do ? Just send a keycode ? That should be unconditionnal.
The Fn key should change a keycode always. I don't see why you would
that to be off.

> pb_fkeyslast is to emulate the behaviour of KBDMode from pbbuttonsd.
> The last one, pb_disablekeypad could left out. It doesn't add much code
> and might be used by some people, too.

The ony one we need is the one enabling/disabing the old behaviour.

Ben.



