Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264952AbVBFJTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbVBFJTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 04:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbVBFJTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 04:19:36 -0500
Received: from gprs215-103.eurotel.cz ([160.218.215.103]:10658 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S272940AbVBFJSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 04:18:41 -0500
Date: Sun, 6 Feb 2005 10:18:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.11-rc[23]: swsusp & usb regression
Message-ID: <20050206091822.GA1096@elf.ucw.cz>
References: <20050204231649.GA1057@elf.ucw.cz> <Pine.LNX.4.44L0.0502052053160.10183-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0502052053160.10183-100000@netrider.rowland.org>
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
> > I tried deselecting CONFIG_USB_EHCI_HCD, and got repeating stream of
> >
> > Feb  5 00:21:17 amd kernel: Restarting tasks... done
> > Feb  5 00:21:17 amd kernel: hub 3-0:1.0: over-current change on port 1
> > Feb  5 00:21:18 amd kernel: hub 3-0:1.0: connect-debounce failed, port 1 disabled
> > Feb  5 00:21:18 amd kernel: hub 3-0:1.0: over-current change on port 2
> > Feb  5 00:21:20 amd kernel: hub 3-0:1.0: connect-debounce failed, port 2 disabled
> 
> Considering all the known problems in uhci-hcd's suspend support, I'm not 
> sure it's worth pursuing this.  On the other hand, all those "over-current 
> change" messages you kept getting might indicate a more serious kind of 
> failure.

Oops, I tried again with latest -bk kernel and no patches, and it
works okay; that means that failure was probably caused by my local
patches.

Sorry about the noise.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
