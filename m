Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWIAQCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWIAQCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWIAQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:02:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:6799 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932278AbWIAQCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:02:10 -0400
X-Authenticated: #24096462
Date: Fri, 1 Sep 2006 18:02:30 +0200
From: Jan-Hendrik Zab <xaero@gmx.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [linux-usb-devel] Problem with USB storage devices, error -110
Message-ID: <20060901180230.100f5783@localhost>
In-Reply-To: <Pine.LNX.4.44L0.0609011006190.6444-100000@iolanthe.rowland.org>
References: <20060831202621.1ae04865@localhost>
	<Pine.LNX.4.44L0.0609011006190.6444-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.4.0cvs113 (GTK+ 2.10.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 10:12:35 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> It seems pretty clear that the UHCI controller hardware on your PCI
> card isn't working.  The "len=-8/64" messages are a dead giveaway;
> you can't get a negative length with a timeout failure if the
> controller is working right.  At least, not unless you have some
> other USB devices already attached to the same controller and using
> up all the bandwidth.
> 
> The fact that it fails in the same way with all the USB devices you
> attach is another indicator that the controller is bad.

Thanks for the answers. :)

There is also a HP Deskjet 5652 attached to the card which is
recognized correctly and works just fine, as long as I do not insert
any USB storage device. Of course the printer is just a USB 1.1 device.
So I've tried without the ehci_hcd module loaded and everything seemed
to work as it should. (Well, sorry for not trying this earlier.) So, at
least the UHCI part seems to work as long as there are no EHCI
'functions' involved.
I'll try to get a new adaptor card then. 

Greets,
    Jan-Hendrik Zab

