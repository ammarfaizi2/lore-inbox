Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbTIUAPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 20:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIUAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 20:15:40 -0400
Received: from main.gmane.org ([80.91.224.249]:26271 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261587AbTIUAPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 20:15:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: 2.4.22 USB problem (uhci)
Date: Sat, 20 Sep 2003 17:15:57 -0700
Message-ID: <m2r82bvvwi.fsf@tnuctip.rychter.com>
References: <m2znh1pj5z.fsf@tnuctip.rychter.com> <20030919190628.GI6624@kroah.com>
 <m2d6dwr3k8.fsf@tnuctip.rychter.com> <20030919201751.GA7101@kroah.com>
 <m28yokr070.fsf@tnuctip.rychter.com> <20030919204419.GB7282@kroah.com>
 <m2smmspjjq.fsf@tnuctip.rychter.com> <20030919212232.GG7282@kroah.com>
 <m2brtgpg1a.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:aRCwEayRvts4fus6qdIejfkUCxs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan" == Jan Rychter <jan@rychter.com>:
>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
 Jan> [...]

 > Please allow me to restate the original problem:
 >
 > -- I usually use uhci instead of usb-uhci, because it is able to go
 > into "suspend mode" when no devices are plugged, which allows the CPU
 > to enter C3 states,
 >
 > -- usb-uhci eats CPU power by keeping it in C2 constantly because of
 > busmastering DMA activity, therefore being much less useful,
 >
 > -- uhci generally works for me just fine, but breaks in one
 > particular case, when removing the device causes a strange message to
 > be printed and the system being unable to use the C3 states again,
 > until uhci is unloaded and reloaded back again.
 >
 > Just as a reminder, this message is:
 >
 > uhci.c: efe0: host controller halted. very bad
 >
 > I hope if the message says "very bad", then this is something that
 > can be fixed. I was therefore reporting a problem with "uhci" and
 > kindly asking for help.

 Greg> Ok, sorry for the confusion.  No I don't know of a fix for this
 Greg> problem, but one just went into the 2.6 kernel tree for the
 Greg> uhci-hcd driver that you might want to take a look at that fixed
 Greg> a problem almost exactly like this.

 Jan> Greg,

 Jan> I've looked at uhci.c, the message comes from line 2461, in
 Jan> uhci_interrupt. But there is no chance I will be able to fix it
 Jan> without first understanding thoroughly how uhci.c works.

 Jan> So I guess this goes into my "unfixed Linux bugs" bin.

I've just realized that some people may not know why the above uhci bug
is a problem.

Having done some measurements and calculations, the above uhci bug
translates into a shortened battery life: 20 minutes less for the laptop
I've been testing on. You get 1h30 instead of 1h50 you would normally
get if uhci would work correctly.

That's like having only 84% of your battery available to start with.

--J.

