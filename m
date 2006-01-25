Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWAYEnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWAYEnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 23:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWAYEnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 23:43:39 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25287
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751004AbWAYEni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 23:43:38 -0500
Date: Tue, 24 Jan 2006 20:43:31 -0800
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: EHCI + APIC errors = no usb goodness
Message-ID: <20060125044331.GA4994@suse.de>
References: <20060123210443.GA20944@suse.de> <200601240722.21108.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240722.21108.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:22:20AM +0100, Andi Kleen wrote:
> On Monday 23 January 2006 22:04, Greg KH wrote:
> > I've had a laptop here that has had some "issues" in the past (time
> > running double speed, XFree doesn't work, etc.)
> > 
> > Now I'm down to the last problem, USB doesn't work, which is a bit of a
> > pain for me :)
> > 
> > Anyway, below is the kernel log from 2.6.16-rc1-mm2 (contains the latest
> > acpi tree, which I thought might help out.)  This log is when I modprobe
> > ehci-hcd.  The interesting thing is the APIC error, 
> 
> That was the laptop with ATI chipset right? Most of them have routing
> troubles with the timer interrupt. I finally gave up trying to fix
> them and just switched over to using the APIC timer which is run
> by the CPU and not dependent on chipsets. Use the latest
> patch from my x86-64 queue ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/

Yes, this is the same laptop.

Turns out this was a bug in the USB EHCI bios handoff logic, a newer
patch from David fixed it.  The APIC stuff was just a false alarm, and
for now, I've just turned it off, thanks to Pete reminding me about it.

When I get this laptop converted to 64bit, I'll try out your patches.

thanks,

greg k-h
