Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbVBFCAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbVBFCAC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbVBFCAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:00:01 -0500
Received: from netrider.rowland.org ([192.131.102.5]:3855 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S265981AbVBFB7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:59:33 -0500
Date: Sat, 5 Feb 2005 20:59:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.11-rc[23]: swsusp & usb regression
In-Reply-To: <20050204231649.GA1057@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0502052053160.10183-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005, Pavel Machek wrote:

> Hi!
> 
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

> I tried deselecting CONFIG_USB_EHCI_HCD, and got repeating stream of
>
> Feb  5 00:21:17 amd kernel: Restarting tasks... done
> Feb  5 00:21:17 amd kernel: hub 3-0:1.0: over-current change on port 1
> Feb  5 00:21:18 amd kernel: hub 3-0:1.0: connect-debounce failed, port 1 disabled
> Feb  5 00:21:18 amd kernel: hub 3-0:1.0: over-current change on port 2
> Feb  5 00:21:20 amd kernel: hub 3-0:1.0: connect-debounce failed, port 2 disabled

Considering all the known problems in uhci-hcd's suspend support, I'm not 
sure it's worth pursuing this.  On the other hand, all those "over-current 
change" messages you kept getting might indicate a more serious kind of 
failure.

Does setting CONFIG_USB_SUSPEND help at all?

Alan Stern

