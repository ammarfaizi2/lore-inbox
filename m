Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTIIV3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIIV3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:29:51 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:54912
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264409AbTIIV3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:29:36 -0400
Date: Tue, 9 Sep 2003 17:28:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
 data
In-Reply-To: <1063142578.30981.22.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0309091728030.14426@montezuma.fsmlabs.com>
References: <20030909204803.N4216@flint.arm.linux.org.uk> 
 <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com> 
 <20030909220452.S4216@flint.arm.linux.org.uk> <1063142578.30981.22.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Alan Cox wrote:

> On Maw, 2003-09-09 at 22:04, Russell King wrote:
> > I want this to be foolproof, because its me people bug when their cardbus
> > cards oops when they insert the damned things.  If people are happy to
> > ignore this issue, I'm happy to ignore the bug reports.
> > 
> > It basically isn't something I want to deal with, and we need to find a
> > way to stop these stupidities appearing in the first place.
> > 
> > Any ideas?
> 
> You've already got symbols for initdata start and end, just check the 
> pointers in the pci_register code. I guess you want a per platform
> 
> BUG_IF_INIT(x)

I hacked up something similar, but i'm not sure what to do about modules.
