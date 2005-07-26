Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVGZNDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVGZNDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGZNDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:03:35 -0400
Received: from styx.suse.cz ([82.119.242.94]:27544 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261761AbVGZNDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:03:30 -0400
Date: Tue, 26 Jul 2005 15:03:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [INPUT] simple question on driver initialisation.
Message-ID: <20050726130329.GA3215@ucw.cz>
References: <20050726120108.GA2101@ucw.cz> <20050726122602.22799.qmail@web25810.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050726122602.22799.qmail@web25810.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 02:26:02PM +0200, moreau francis wrote:
> Thanks Vojtech for your answers !
> 
> --- Vojtech Pavlik <vojtech@suse.cz> a écrit :
> 
> > It's also available via an ioctl() and in sysfs. This allows you to
> > specify in an application that you want a device plugged into a specific
> > port of the machine. Not many applications can use it at the moment, but
> > udev can use it to assign a name of the device node.
> > 
> 
> hmm, how can I use ioctl to find the location device since I need the location
> to pass it to ioctl ?
> 
> I can't find "pinpad/input0" in sysfs, does that mean I need to add sysfs
> suppport in my driver, and it's not done in input module when I register 
> my input driver ?

I'm sorry, I thought it's already in mainline, but that bit is still
missing from the sysfs support in input. It'll get there soon.

> > "pinpad/input0" doesn't sound right. What port is your pinpad connected
> > to?
> 
> Actually I'm working on an embedded system which owns a pinpad controller.
> This controller is accessed by using io mem and it talks to the pinpad through
> a dedicated bus. So I accessed it through io space.

In that case, you'll likely want something like io0200/input0, where
0x200 would be the io address of the device. On the other hand, if it's
really embedded and there can't be two pinpads in the system, it's not a
problem to use basically any string there, since it only needs to be
system-unique.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
