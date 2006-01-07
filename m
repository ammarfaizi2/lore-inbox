Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWAGAuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWAGAuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWAGAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:50:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:42890 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030257AbWAGAuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:50:51 -0500
Subject: Re: request for opinion on synaptics, adb and powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0601070053470.2702@telia.com>
References: <20060106231301.GG4732@kamaji.shammash.lan>
	 <Pine.LNX.4.58.0601070053470.2702@telia.com>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:51:37 +1100
Message-Id: <1136595097.4840.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Fedora handles this situation by always installing the synaptics package
> and setting up the X config file automatically if the computer has a
> synaptics touchpad. I guess this approach could work for other
> distributions too.

The problem we have is a bit different (or I didn't understand
something). The mac trackpad has it's own kernel driver and is all
relative mode. Luca's patch will make it work in absolute mode instead
for use with X synaptic driver, thus providing more "features" than the
default relative-mode one.

So what we are looking for is a way to have the kernel driver switch
between raw and ps2 modes based on instruction/ioctl from the userland
client (the X synaptic driver). This shouldn't be much of a problem if
the X synaptic driver switches it to raw at X start and on EnterVT and
back to what it was on LeaveVT...

Ben.


