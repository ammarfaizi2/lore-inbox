Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTISWax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTISWax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:30:53 -0400
Received: from screech.rychter.com ([212.87.11.114]:35484 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S261769AbTISWau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:30:50 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
References: <m2znh1pj5z.fsf@tnuctip.rychter.com>
	<20030919190628.GI6624@kroah.com> <m2d6dwr3k8.fsf@tnuctip.rychter.com>
	<20030919201751.GA7101@kroah.com> <m28yokr070.fsf@tnuctip.rychter.com>
	<20030919204419.GB7282@kroah.com> <m2smmspjjq.fsf@tnuctip.rychter.com>
	<20030919212232.GG7282@kroah.com>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Fri, 19 Sep 2003 15:30:41 -0700
In-Reply-To: <20030919212232.GG7282@kroah.com> (Greg KH's message of "Fri,
 19 Sep 2003 14:22:32 -0700")
Message-ID: <m2brtgpg1a.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

[...]

 >> Please allow me to restate the original problem:
 >>
 >> -- I usually use uhci instead of usb-uhci, because it is able to go
 >> into "suspend mode" when no devices are plugged, which allows the
 >> CPU to enter C3 states,
 >>
 >> -- usb-uhci eats CPU power by keeping it in C2 constantly because of
 >> busmastering DMA activity, therefore being much less useful,
 >>
 >> -- uhci generally works for me just fine, but breaks in one
 >>    particular
 >> case, when removing the device causes a strange message to be
 >> printed and the system being unable to use the C3 states again,
 >> until uhci is unloaded and reloaded back again.
 >>
 >> Just as a reminder, this message is:
 >>
 >> uhci.c: efe0: host controller halted. very bad
 >>
 >> I hope if the message says "very bad", then this is something that
 >> can be fixed. I was therefore reporting a problem with "uhci" and
 >> kindly asking for help.

 Greg> Ok, sorry for the confusion.  No I don't know of a fix for this
 Greg> problem, but one just went into the 2.6 kernel tree for the
 Greg> uhci-hcd driver that you might want to take a look at that fixed
 Greg> a problem almost exactly like this.

Greg,

I've looked at uhci.c, the message comes from line 2461, in
uhci_interrupt. But there is no chance I will be able to fix it without
first understanding thoroughly how uhci.c works.

So I guess this goes into my "unfixed Linux bugs" bin.

--J.
