Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVCNTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVCNTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVCNTUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:20:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:42369 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261745AbVCNTUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:20:48 -0500
Date: Mon, 14 Mar 2005 20:21:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
Message-ID: <20050314192138.GB1673@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru> <20050314162537.GA2716@ucw.cz> <4235BDFD.1070505@tls.msk.ru> <20050314164342.GA1735@ucw.cz> <4235E0BD.5090200@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235E0BD.5090200@tls.msk.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:06:37PM +0300, Michael Tokarev wrote:

> >>So is this a bios/mobo problem,
> >
> >Yes.
> 
> Never had any single problem with this hardware so far.  But.. uh-oh.
> Well.. it's only 2.6 kernel that encounters problem with it for now,
> so it must be the kernel... ;)

2.4 leaves the mouse initialization to X start time (X does it), and the
USB modules are loaded before X starts, and thus before mouse init.

> >>or can it be solved in kernel somehow?

> >We could have usb-handoff by default.
> 
> What's the consequences of this?
> If it does not hurt (does it?), why not to enable it?

Alan Cox reports some odd machines crash with it.
I haven't seen one myself yet.

> And if it does not hurt, I can enable it in our default netboot
> image as well.. if not to see whenever all our machines will work
> ok with this parameter.

SuSE has it by default, with an option to disable it by no-usb-handoff,
that should tell you how large is the percentage of machines it breaks.

It's pretty safe to enable it in your netboot image.

> Thank you very much - this mysterious problem.. I was trying to
> find the solution for quite some time before posting to LKML,
> without any success, and the solution was already here! ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
