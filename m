Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSJVRKV>; Tue, 22 Oct 2002 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264780AbSJVRKV>; Tue, 22 Oct 2002 13:10:21 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:49862 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264779AbSJVRKQ>;
	Tue, 22 Oct 2002 13:10:16 -0400
Date: Tue, 22 Oct 2002 10:16:17 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: rtnetlink interface state monitoring problems.
Message-ID: <20021022171617.GA22276@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote :
>
> IrDA devices are network devices. The core network code sends a RTM_NETLINK 
> message when they go up or down. All is well, and once the permission fix 
> gets into the kernel I'm using, my irda monitor applet no longer needs to 
> poll the state of the interface.

	Actually, I'm not 100% happy with the IrDA situation. I would
not mind someone exporting more events to RtNetlink, very similar to
the functionality/events I already provide in the IrNET control
channel (discovery/expiry/link blocked/...).
	Note that if you are only interested in IrNET, then the IrNET
control channel gives you everything you need, and you don't really
need to use RtNetlink. Personally, I think the future of IrDA is
IrNET, so that's why I don't bother with the rest.
	In any case, send me a link to you applet, I'll add that on my
web page.

> But Bluetooth devices are not network devices, it seems. There exists no 
> current mechanism for notifying anyone of state changes. Should we invent a 
> new method of notification using netlink, or should Bluetooth interfaces in 
> fact be normal network devices just like IrDA devices are?

	Check this thread :
http://sourceforge.net/mailarchive/forum.php?thread_id=1165868&forum_id=1881
	Basically, you need to check the code in hcid.c (in utils) to
know how to collect this events. I've coded this and it works
perfect. Yeah, it's another socket to manage.

> --
> dwmw2

	Have fun...

	Jean
