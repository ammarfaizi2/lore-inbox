Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUA3RxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUA3RxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:53:08 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:20097 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263618AbUA3RxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:53:05 -0500
Date: Fri, 30 Jan 2004 18:53:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc2 (BK): /proc/bus/input/devices information for joystick bogus?
Message-ID: <20040130175320.GA1308@ucw.cz>
References: <20040130173516.GA4517@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130173516.GA4517@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 06:35:16PM +0100, Matthias Andree wrote:

> I see this in /proc/bus/input/devices:
> 
> I: Bus=0014 Vendor=0001 Product=000f Version=0100
> N: Name="Analog 3-axis 4-button joystick"
> P: Phys=<NULL>/input0
> H: Handlers=js0 
> B: EV=b 
> B: KEY=1b 0 0 0 0 0 0 0 0 0 
> B: ABS=83 
> 
> The <NULL> tag seems to confuse hotplug's input.rc. Where does it come
> from? How can the kernel see the Joystick without knowing the phys
> address?

The module which implemented the gameport didn't set the phys string for
the gameport. Check the sound driver for your sound card.

> (This was also filed as SourceForge.net bug #887724 to the linux-hotplug
> project.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
