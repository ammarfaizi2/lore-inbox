Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWFGAv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFGAv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWFGAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:51:56 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45816 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751189AbWFGAv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:51:56 -0400
Date: Tue, 06 Jun 2006 18:51:53 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-reply-to: <6kl8h-1Uf-15@gated-at.bofh.it>
To: Lee Dowling <ledow@ledow.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44862329.2080702@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6kl8h-1Uf-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Dowling wrote:
> This, of course, doesn't deal with outside cases.
> 
> It's common knowledge that a lot of equipment is running out of spec all 
> the time because of cheap components, bad BIOS's etc.  As an example, my 
> Asus L4500R laptop (with the latest ASUS BIOS) ALWAYS shows 
> "over-current" under Linux on all *internal* USB ports the second 
> ANYTHING is plugged in (and I have nearly 50 different USB devices of 
> different types, manufacturers and quality).
> 
> The suggestion to simply stop over-current ports from working would 
> immediately disable all USB ports, including any powered hubs that I 
> plug into them, I assume.  I can't update the BIOS any further to stop 
> this and if I could I doubt it would solve the problem (it looks like 
> cheap hardware to me).  Therefore, you've just removed all my perfectly 
> functional USB capability because the best BIOS I can use reports an 
> incorrect error (hey, what's new?).

I don't think you assume correctly. Overcurrent indication from the hub 
is supposed to mean that something on the hub is shorted or pulling too 
much current. This discussion is about the kernel refusing to enable 
devices when they would consume more power than the hub they are 
connected to can provide. Regardless of what you do with plugging in 
devices, overcurrent isn't supposed to happen unless something is broken.

> 
> Windows XP, incidentally, runs flawlessly with all USB devices without 
> power warnings on this laptop.  This may well be fixable somewhere else, 
> it may even be a bug in the internal USB code for my laptop which may be 
> help in hunting such bugs down.

Probably either XP ignores the overcurrent indication, or else something 
   in Linux is interacting badly with the controller and causing this 
indication. XP definitely DOES enforce USB power budgeting.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

