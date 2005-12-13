Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVLMTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVLMTit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVLMTit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:38:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:11169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932585AbVLMTit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:38:49 -0500
Date: Tue, 13 Dec 2005 11:38:32 -0800
From: Greg KH <greg@kroah.com>
To: Denny Priebe <spamtrap@siglost.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Message-ID: <20051213193832.GA14047@kroah.com>
References: <20051213184600.GA4283@nostromo.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213184600.GA4283@nostromo.dyndns.info>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 07:46:00PM +0100, Denny Priebe wrote:
> Hello,
> 
> I just want to report a strange observation that I've made while trying to
> setup my Wacom Intuos3 6x11 tablet:
> 
> When I use the tablet (e.g. press a button, move the pen) and do not have
> any process reading the provided data (e.g. there's no process reading 
> /dev/input/mouse0 and there's no process reading /dev/input/event5 in my 
> setup) the tablet disconnects from and immediately reconnects to the USB. 
> There's one pair of disconnect and reconnect each time I press a button or 
> use the pen. These disconnects and reconnects disappear as soon as there's 
> a process reading either /dev/input/mouse0 or /dev/input/event5 (mouse0 and
> event5 according to my setup).
> 
> I'm able to reproduce this with 2.6.15-rc5, 2.6.15-rc4, and 2.6.14.3,
> but haven't tried other kernels yet.

Sounds like a hardware problem, the kernel can't cause a device to
electronically disconnect itself like this.

I suggest plugging this into a different port, using a powered hub, or
checking that the cable is still good.

good luck,

greg k-h
