Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266103AbVBEJYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266103AbVBEJYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbVBEJYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:24:15 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:20418 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266504AbVBEJW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:22:57 -0500
Date: Sat, 5 Feb 2005 00:23:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc[23]: swsusp & usb regression
Message-ID: <20050204232302.GA1060@elf.ucw.cz>
References: <20050204231649.GA1057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204231649.GA1057@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In 2.6.11-rc[23], I get problems after swsusp resume:
> 
> Feb  4 23:54:39 amd kernel: Restarting tasks...<3>hub 3-0:1.0:
> over-current change on port 1
> Feb  4 23:54:39 amd kernel:  done
> Feb  4 23:54:39 amd kernel: hub 3-0:1.0: connect-debounce failed, port
> 1 disabled
> Feb  4 23:54:39 amd kernel: hub 3-0:1.0: over-current change on port 2
> Feb  4 23:54:39 amd kernel: usb 3-2: USB disconnect, address 2
> 
> After unplugging usb bluetooth key, machine hung. Sysrq still
> responded with help but I could not get any usefull output.

I tried deselecting CONFIG_USB_EHCI_HCD, and got repeating stream of

Feb  5 00:21:17 amd kernel: Restarting tasks... done
Feb  5 00:21:17 amd kernel: hub 3-0:1.0: over-current change on port 1
Feb  5 00:21:18 amd kernel: hub 3-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:18 amd kernel: hub 3-0:1.0: over-current change on port 2
Feb  5 00:21:20 amd kernel: hub 3-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:20 amd kernel: hub 1-0:1.0: over-current change on port 1
Feb  5 00:21:21 amd kernel: hub 1-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:21 amd kernel: hub 1-0:1.0: over-current change on port 2
Feb  5 00:21:23 amd kernel: hub 1-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:23 amd kernel: hub 2-0:1.0: over-current change on port 1
Feb  5 00:21:24 amd kernel: hub 2-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:24 amd kernel: hub 2-0:1.0: over-current change on port 2
Feb  5 00:21:24 amd kernel: usb 2-2: USB disconnect, address 2
Feb  5 00:21:26 amd kernel: hub 2-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:26 amd kernel: hub 3-0:1.0: over-current change on port 1
Feb  5 00:21:28 amd kernel: hub 3-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:28 amd kernel: hub 3-0:1.0: over-current change on port 2
Feb  5 00:21:29 amd kernel: hub 3-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:29 amd kernel: hub 1-0:1.0: over-current change on port 1
Feb  5 00:21:31 amd kernel: hub 1-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:31 amd kernel: hub 1-0:1.0: over-current change on port 2
Feb  5 00:21:32 amd kernel: hub 1-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:32 amd kernel: hub 2-0:1.0: over-current change on port 1
Feb  5 00:21:34 amd kernel: hub 2-0:1.0: connect-debounce failed, port
1 disabled
Feb  5 00:21:34 amd kernel: hub 2-0:1.0: over-current change on port 2
Feb  5 00:21:35 amd kernel: hub 2-0:1.0: connect-debounce failed, port
2 disabled
Feb  5 00:21:35 amd kernel: hub 3-0:1.0: over-current change on port 1


...in syslog.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
