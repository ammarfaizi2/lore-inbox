Return-Path: <linux-kernel-owner+w=401wt.eu-S1750871AbXACPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXACPb0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXACPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:31:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:54965 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbXACPbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:31:25 -0500
In-Reply-To: <20070102.203828.70220767.davem@davemloft.net>
References: <20070102.140749.104035927.davem@davemloft.net> <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org> <Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr> <20070102.203828.70220767.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <361567791f8bd777c73f0f94174b73dc@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 16:31:45 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Kill OF? sparc does not want that IMO, how else should I return to
>> the 'ok' prompt?
>
> PowerPC kills OF because it really has to,

No it doesn't.  It has to on some (very common, heh) subarchs.

> that's one of numerous
> reasons that it started sucking the device tree into a kernel copy
> early in the bootup and using that for device discovery etc.
>
> To be honest, the 'ok' prompt is of limited value when you have
> things like Alt-SysRq and PPC's XMON debugger in the kernel already.

When I ported the PowerPC kernel to a new platform years ago,
the big problems happened *before* any of those methods worked,
at really early boot time (the PowerPC port has become a lot
better since then fwiw, it might be easier now).  Running (and
debugging) other client programs was a lot easier, since you
could always drop back to OF on panic conditions so you could
investigate what was going on without using hardware probes.

> In fact, the 'ok' prompt is an ENORMOUS pain in the ass to support
> on machines with USB keyboards, because sharing the USB host
> controller is beyond non-trivial.  I've never implemented support
> for that on sparc64 and I frankly have no desire to do the work
> necessary to support that.  It simply is not worth it.

Oh yes, USB keyboards, lovely.  Use a serial port, or a dedicated
network controller, or similar, for the OF console instead ;-)


Segher

