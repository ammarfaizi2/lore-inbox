Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAUAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAUAEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVAUAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:04:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:62861 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261274AbVAUAE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:04:26 -0500
Subject: Re: Radeon framebuffer weirdness in -mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       ajoshi@shell.unixbox.com,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050120153921.11d7c4fa.akpm@osdl.org>
References: <20050120232122.GF3867@waste.org>
	 <20050120153921.11d7c4fa.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 11:03:14 +1100
Message-Id: <1106265794.18397.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 15:39 -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> 
> Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> 
> (cc Ben, who is the likely cuprit ;)
> 
> Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?
> 
> Did you try the corresponding -mm1?

/me curses possible BIOS crap ...

radeonfb tries to restore initial mode when the module is closed, which
wouldn't work for a VGA text thing in fact... I suspect something cause
driver remove() routines to be called on reboot, can you confirm ? Or is
it a module that gets removed ? It may well be a problem that has always
been there (regardless of the radeon driver version) and just triggered
by something the kernel does on reboot...

Ben.


