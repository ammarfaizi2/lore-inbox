Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271829AbTGXX4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTGXX4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:56:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:38095 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271829AbTGXX4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:56:09 -0400
Date: Fri, 25 Jul 2003 02:11:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, schierlm@gmx.de,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030725001115.GA30327@ucw.cz>
References: <bXg8.4Wg.1@gated-at.bofh.it> <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org> <20030724212416.GA18141@vana.vc.cvut.cz> <20030724225745.GA434@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724225745.GA434@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 12:57:45AM +0200, Pavel Machek wrote:

> Hi!
> 
> > This all happens on Compaq EVO N800C. I strongly believe that we need a
> > build time option for disabling Synaptics detection, or at least input_synaptics=0
> > runtime option, until it can work at least as well as it works like ps/2
> > device.
> 
> Agreed, I even send a patch to vojtech, he said he is going to apply
> it and I have not heard about that patch after that...

For proper Synaptics support an XFree86 driver is available (get it at
http://w1.894.telia.com/~u89404340/touchpad/index.html). This will allow
for full support, including gesture recongition. Passthrough support for
enabling the touchpoint or external mice chained to the Synaptics pad is
pending in my patch queue and will be merged as soon as I return from
Ottawa.

Support for touchpads is nonexistent in mousedev.c, it only supports
mice, digitizers and touchscreens. Just adding an entry to the device
tableis futile, you'd need much much more than that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
