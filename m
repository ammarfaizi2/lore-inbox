Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266382AbVBEXOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266382AbVBEXOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 18:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbVBEXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 18:14:48 -0500
Received: from gprs215-88.eurotel.cz ([160.218.215.88]:4796 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266269AbVBEXOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 18:14:41 -0500
Date: Sun, 6 Feb 2005 00:14:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.11-rc[23]: swsusp & usb regression
Message-ID: <20050205231428.GA1098@elf.ucw.cz>
References: <20050204231649.GA1057@elf.ucw.cz> <Pine.LNX.4.44L0.0502051006150.31778-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0502051006150.31778-100000@netrider.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In 2.6.11-rc[23], I get problems after swsusp resume:
> > 
> > Feb  4 23:54:39 amd kernel: Restarting tasks...<3>hub 3-0:1.0:
> > over-current change on port 1
> > Feb  4 23:54:39 amd kernel:  done
> > Feb  4 23:54:39 amd kernel: hub 3-0:1.0: connect-debounce failed, port
> > 1 disabled
> > Feb  4 23:54:39 amd kernel: hub 3-0:1.0: over-current change on port 2
> > Feb  4 23:54:39 amd kernel: usb 3-2: USB disconnect, address 2
> > 
> > After unplugging usb bluetooth key, machine hung. Sysrq still
> > responded with help but I could not get any usefull output.
> 
> Your logs don't indicate which host controller driver is bound to each of 
> your hubs.  /proc/bus/usb/devices will contain that information.  Without 
> it, it's hard to diagnose what happened.

I do not think I have any hubs... no external hubs anyway. And I do
not have /proc/bus/usb/devices file :-(. There's something in
/sys/bus/usb/devices/.

> As things stand now, however, there's likely to be lots of problems in the 
> coordination of suspend/resume activities among the HCDs, the glue layer, 
> and the hub driver.  One thing you could try is to turn on 
> CONFIG_USB_SUSPEND.  It's likely to change things, although not 
> necessarily for the better.  :-)

:-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
