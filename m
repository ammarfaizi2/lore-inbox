Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUA0Idh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 03:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUA0Idh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 03:33:37 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:5248 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S262913AbUA0Idf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 03:33:35 -0500
Date: Tue, 27 Jan 2004 09:33:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Voluspa <lista3@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c: Unknown key released
Message-ID: <20040127083338.GA490@ucw.cz>
References: <200401270716.i0R7Gxw21819@d1o408.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401270716.i0R7Gxw21819@d1o408.telia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 08:16:59AM +0100, Voluspa wrote:

> > > I keep getting the following in my syslog whenever I startx:
> 
> In fact, it is preemptively written even _before_ I start X :-)
> I'm using an ancient IBM PS2 swedish keyboard, and this 0x7a crap began
> showing somewhere at 2.6.1 (then without blaming X). Now it is - and the
> blame on X came with 2.6.2-rc2:
> 
> Booting:
> 
> Jan 26 16:29:10 loke kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 26 16:29:10 loke kernel: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.
> Jan 26 16:29:11 loke kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 26 16:29:11 loke kernel: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.

Do you use 'kbdrate' in your bootup scripts? That's another one touching
the keyboard controller directly, when there are ioctls for that.

I guess I should modify to make the message not point not directly to X,
but 'some application'.

> Starting X:
> 
> Jan 26 16:33:50 loke kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 26 16:33:50 loke kernel: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.
> Jan 26 16:33:50 loke kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 26 16:33:50 loke kernel: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
