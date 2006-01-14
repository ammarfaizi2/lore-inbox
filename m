Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWANRJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWANRJI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWANRJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:09:07 -0500
Received: from mx1.rowland.org ([192.131.102.7]:29449 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750700AbWANRJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:09:06 -0500
Date: Sat, 14 Jan 2006 12:09:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Walt H <walt_h@lorettotel.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, <dmitry.torokhov@qmail.com>,
       <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <43C908C0.9090706@lorettotel.net>
Message-ID: <Pine.LNX.4.44L0.0601141206280.8167-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Walt H wrote:

> I've an AMD based SMP setup w/ Chaintech 7KDD motherboard. It's an older 
> board, and there are no more recent BIOS updates available for me than 
> what I'm running. I've tried enabling/disabling legacy USB 
> keyboard/mouse emulation in the BIOS with no change.  I'm using a USB 
> mouse connected via the OHCI controller in addition to the ps/2 
> keyboard.  If I comment out the handoff code in pci-quirks.c the 
> keyboard works, even after loading the USB modules. I'm running a ck 
> based 2.6.15 kernel BTW.
> 
> During bootup with handoff code enabled, I do see a message print when 
> PS/2 gets init'd, and I think it is
> "i8042.c: Can't read CTR while initializing i8042", but it scrolls by 
> too fast so I'm not positive.
> 
> lspci and config attached.  Anything else you need?  Please CC replies 
> to me, as I'm not subscribed.  I tried to CC relevant people involved, 
> sorry if I missed anyone. Thanks,

What happens if you comment out only the OHCI part of the hand-off code, 
or only the EHCI part?

Check dmesg to see exactly what that i8042 message says.  Are there any 
lines reporting handoff problems in ohci-hcd or ehci-hcd?

Alan Stern

