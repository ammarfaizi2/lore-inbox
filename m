Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319164AbSILX0N>; Thu, 12 Sep 2002 19:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319165AbSILX0M>; Thu, 12 Sep 2002 19:26:12 -0400
Received: from CPE-144-132-190-206.nsw.bigpond.net.au ([144.132.190.206]:23959
	"EHLO orthos") by vger.kernel.org with ESMTP id <S319164AbSILX0M>;
	Thu, 12 Sep 2002 19:26:12 -0400
Subject: Re: [Bluez-users] keyboard and mouse lost when bluez does things
From: "Mikolaj J. Habryn" <dichro-evo@rcpt.to>
To: "Maksim (Max)  " Krasnyanskiy <maxk@qualcomm.com>
Cc: bluez-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020912111832.0669a0b8@mail1.qualcomm.com>
References: <5.1.0.14.2.20020912111832.0669a0b8@mail1.qualcomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 09:30:56 +1000
Message-Id: <1031873456.21031.135.camel@orthos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 04:19, Maksim (Max) Krasnyanskiy wrote:
> At 02:27 PM 9/12/2002 +1000, Mikolaj J. Habryn wrote:
> >I have a Brainboxes CF card inside a Toshiba Portege 2000. When I do
> >just about anything with it - hciattach, for example - the keyboard and
> >mouse stop responding. The interrupt counts in /proc/interrupts for them
> >stop incrementing (*boggle*). Switching into and out of X fixes it. Any
> >suggestions?
> I never seen this kind of thing before.
> What kernel is this ?

I was afraid of that :P I see it with 2.4.20-pre{5,6}, 2.4.19 (I think),
and 2.5.32. It's a Toshiba Portege 2000, and I guess that means that
something excitingly wacky is happening with the interrupt hardware.
linux-kernel cc'd in case anyone there has ideas.

I did do some instrumenting inside the bluez code, and it appears to
lose the plot within the serial code somewhere - but not necessarily on
any given call into there. The behaviour is quite odd - for example,
starting an l2ping will immediately lock out the keyboard and mouse, and
the first ping response will show an RTT of ~5500 ms, following which
the remainder will come back within ~45ms. If I leave l2ping running
while restoring the keyboard and mouse by switching in and out of X,
they'll almost immediately freeze up again and there'll be another ~5500
ms burp in the l2ping replies.

m.
