Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVCRXpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVCRXpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCRXpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:45:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11924 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262118AbVCRXox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:44:53 -0500
Date: Sat, 19 Mar 2005 00:44:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-ID: <20050318234440.GF24449@elf.ucw.cz>
References: <20050310223353.47601d54.akpm@osdl.org> <20050311130831.GC1379@elf.ucw.cz> <20050318214335.GA17813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050318214335.GA17813@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 18-03-05 13:43:36, Greg KH wrote:
> On Fri, Mar 11, 2005 at 02:08:31PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > This patch has been spitting warnings:
> > > 
> > > drivers/usb/host/uhci-hcd.c:838: warning: initialization from incompatible pointer type
> > > drivers/usb/host/ohci-pci.c:191: warning: initialization from incompatible pointer type
> > > 
> > > Because hc_driver.suspend() takes a u32 as its second arg.  Changing that
> > > to pci_power_t causes build failures and including pci.h in usb.h seems
> > > wrong.
> > > 
> > > Wanna fix it sometime?
> > 
> > Yep. Here it is.
> > 
> > This fixes remaining confusion. Part of my old patch was merged, I
> > later decided passing pci_power_t down to drivers is bad idea; this
> > passes them pm_message_t which contains more info (and actually works
> > :-). Please apply,
> 
> Argh, this one is already partially in, and another one you just sent me
> has half of it in the tree too...
> 
> Care to just rediff off of 2.6.12-rc1?  Then we can hopefully get these
> changes in :)

I can do the rediff tommorow. I just hope there are not some other
changis waiting in -mm to spoil this ;-).
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
