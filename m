Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSAWVPS>; Wed, 23 Jan 2002 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290104AbSAWVPI>; Wed, 23 Jan 2002 16:15:08 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:48908 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S290103AbSAWVPC>;
	Wed, 23 Jan 2002 16:15:02 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Wed, 23 Jan 2002 22:14:49 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: hot IDE change
CC: linux-kernel@vger.kernel.org, ertzog@bk.ru
X-mailer: Pegasus Mail v3.40
Message-ID: <FBFD7B7521F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 02 at 15:56, Richard B. Johnson wrote:
> > This question is more about hardware, but is also related to Linux.
> > If I have a harddisk, plugged into the motherboard (IDE cable and power),
> > can I turn it off, plugging out first power cable, then IDE cable.
> > Can it harm harddisk or motherboard?
> > If I can do it, then will Linux detect it back, if I make this 
> > operation back: i.e. plug IDE cable, then power cable.
> 
> Linux doesn't care as long as it has been dismounted.

Do not forget to run 'sync' after you dismount it.

> So, you decide to pull the IDE cable first. Well, if you made
> sure that all active bits were disconnected at the same time,
> (grin), maybe you can get away with it.

My non-hotpluggable bay first disconnect power, and it works fine,
every friday evening for more than two years... But I have this
device alone on its cable, so there is no traffic when I disconnect it.
And I probably lost warranty by doing that.
 
> Now, do you want to plug in another drive? If the five-volts
> isn't present before the +12V, you may back-feed the 5-volt
> logic through its protection diodes. If this generates enough

Unless something changed behind my back, do not do it. As kernel
have no idea that you removed drive, it will not invalidate its
caches. Maybe you could workaround this (at least you have to ask
it to rescan partition table), but I decided to not plug IDE HDD into
machine when kernel runs. So I reboot my system on each Monday morning, 
and I plug hdd in when BIOS checks memory. It resets your uptime to zero,
but as I upgrade kernel much more often, it is not a big problem.

Only problem I had were ATAPI devices. There is stupid paragraph about
creating `virtual' slave when none is present, in the ATAPI standard,
and so even if you plug HDD into the box as a slave to ATAPI device,
you'll not see it until you powercycle your ATAPI device... At least
my Chineese CDROM behaves that way, so I put it on its own cable.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz


