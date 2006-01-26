Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWAZRvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWAZRvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAZRvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:51:50 -0500
Received: from hera.kernel.org ([140.211.167.34]:22506 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751349AbWAZRvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:51:49 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFT] sky2: pci express error fix
Date: Thu, 26 Jan 2006 09:51:45 -0800
Organization: OSDL
Message-ID: <20060126095145.7d6fc4e4@dxpl.pdx.osdl.net>
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
	<20060124220533.5fade501@localhost.localdomain>
	<drasb9$5jj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1138297906 20866 10.8.0.74 (26 Jan 2006 17:51:46 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 26 Jan 2006 17:51:46 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006 01:11:20 +0900
Kalin KOZHUHAROV <kalin@thinrope.net> wrote:

> Stephen Hemminger wrote:
> > For all those people suffering with pci express errors
> > on the sky2 driver.  The problem is the PCI subsystem sometimes
> > won't let the sky2 driver write to PCI express registers. It depends
> > on the phase of the moon (actually ACPI) and number of devices.
> > 
> > Anyway, this should fix it. Please tell me if it solves it for you.
> 
> Can you describe the bug a bit more? What happens?
> 
> I had a few times something like this:
> 
> [   24.145040] sky2 eth0: phy interrupt status 0x1c40 0xbc0c

> 
> [ 3647.341757] sky2 eth0: phy interrupt status 0x1c40 0xbc4c
>

Looks like a noisy crappy cable causing PHY link status changes.


> after which all network was dead. (and it wasn't a module so had to
> restart). As you can see from the above two logs, sometimes it failed on
> boot, sometimes after an hour. Sourry, I didn't remember the phase of the
> moon, but I can check :-)
> 
> I have two Asus P5GDC-V Deluxe boards, with these chips. One of them is
> happily working with sk98lin (the binary one), the other is dying miserably,
> so now I use r8169 card to be able to isolate the problem (separate mail).
> 
>
