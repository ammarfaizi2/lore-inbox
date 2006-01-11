Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWAKVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWAKVee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWAKVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:34:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:38611 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750808AbWAKVed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:34:33 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060111212056.GC6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	 <20060111212056.GC6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:34:17 +1100
Message-Id: <1137015258.5138.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 22:20 +0100, Michael Hanselmann wrote:
> On Wed, Jan 11, 2006 at 04:07:37PM -0500, Dmitry Torokhov wrote:
> > Ok, I am looking at the patch again, and I have a question - do we
> > really need these 3 module parameters? If the goal is to be compatible
> > with older keyboards then shouldn't we stick to one behavior?
> 
> The old keyboard was controlled by ADB (Apple Desktop Bus) commands sent
> by pbbuttonsd. That doesn't work for the USB keyboard because the
> conversion is not done in hardware like with the old ones. ioctl's would
> also be possible, but I'm not sure wether they would be easy to do for
> USB devices. Module parameters can be changed using sysfs.

Yeah, but the question is why 3 ? I think one (on/off) is enough. Do you
have any case where people actually change the other ones ?

Ben.


