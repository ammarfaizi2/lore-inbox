Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWAKVuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWAKVuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWAKVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:50:11 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:27421 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750951AbWAKVuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:50:10 -0500
Date: Wed, 11 Jan 2006 22:50:07 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111215007.GH6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com> <20060111212056.GC6617@hansmi.ch> <1137015258.5138.20.camel@localhost.localdomain> <20060111213805.GE6617@hansmi.ch> <1137015669.5138.22.camel@localhost.localdomain> <20060111214351.GF6617@hansmi.ch> <20060111214732.GA12014@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111214732.GA12014@midnight.suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:47:32PM +0100, Vojtech Pavlik wrote:
> > No, if that parameter is disabled, it translates key combinations like
> > Fn+F1 to KEY_BRIGHTNESSUP. If it's enabled, it only sends KEY_FN.

> I believe a better behavior would be to send KEY_FN and then
> KEY_BRIGHTNESSUP when enabled and KEY_FN and KEY_F1 when disabled.

That's done. It sends KEY_FN as any other key. If a key is pressed while
the fn key is pressed, it uses the table to look up the new code.
Releasing is also done with the corresponding keycodes.

Greets,
Michael
