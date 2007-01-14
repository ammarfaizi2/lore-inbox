Return-Path: <linux-kernel-owner+w=401wt.eu-S1751205AbXANJ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXANJ6H (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbXANJ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:58:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1920 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751205AbXANJ6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:58:04 -0500
Date: Sun, 14 Jan 2007 10:58:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Berthold Cogel <cogel@rrz.uni-koeln.de>,
       Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       gregkh@suse.de
Subject: Re: 2.6.20-rc4: usb somehow broken
Message-ID: <20070114095808.GU7469@stusta.de>
References: <200701111820.46121.prakash@punnoor.de> <200701111828.02119.oliver@neukum.org> <200701141008.49986.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701141008.49986.prakash@punnoor.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 10:08:37AM +0100, Prakash Punnoor wrote:
> Am Donnerstag 11 Januar 2007 18:28 schrieb Oliver Neukum:
> > Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
> > > Hi,
> > >
> > > I can't scan anymore. :-( I don't know which rc kernel introduced it, but
> > > this are the messages I get (w/o touching the device/usb cable except
> > > pluggin it in for the first time):
> > >
> > > usb 1-1.2: new full speed USB device using ehci_hcd and address 4
> > > ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
> > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > usb 1-1.2: USB disconnect, address 4
> > > usb 1-1.2: new full speed USB device using ehci_hcd and address 5
> > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > usb 1-1.2: USB disconnect, address 5
> > > usb 1-1.2: new full speed USB device using ehci_hcd and address 6
> > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > usb 1-1.2: USB disconnect, address 6
> > > usb 1-1.2: new full speed USB device using ehci_hcd and address 7
> > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > usb 1-1.2: USB disconnect, address 7
> > > usb 1-1.2: new full speed USB device using ehci_hcd and address 8
> > > usb 1-1.2: configuration #1 chosen from 1 choice
> > >
> > >
> > > Shouldn't the ohci module handle the scanner? The scanner is connected
> > > through a hub.
> >
> > Therefore it goes to EHCI. Can you try a direct connection?
> >
> > > I don't remember how 2.6.19 handled it, or whether I used some new exotic
> > > setting which causes the breakage.
> >
> > Could you try 2.6.19?
> >
> > > Well, I'll test this week-end and upload more infos then. If you already
> > > have some ideas in the meantime, let me know.
> >
> > Please test with CONFIG_USB_DEBUG
> 
> 
> Hi, I did more tests and I was wrong about "broken". It seems more a time-out 
> problem, ie if I try to use sane again in short intervalls, I will get my 
> device working. The cause seems CONFIG_USB_SUSPEND=y. With 2.6.20-rc5 the 
> situation seems better, ie now I don't get "no device" very less often.
>...


FYI, we already have a report of a different CONFIG_USB_SUSPEND 
regression in 2.6.20-rc:

Subject    : 'shutdown -h now' reboots the system  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Handled-By : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Status     : problem is being debugged



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

