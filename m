Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754208AbWKGL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbWKGL7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbWKGL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:59:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:2284 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1754208AbWKGL7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:59:51 -0500
Date: Tue, 7 Nov 2006 20:53:11 +0900
From: Greg KH <gregkh@suse.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Wolfgang M?es <wolfgang@iksw-muees.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc4] usb auerswald possible memleak fix
Message-ID: <20061107115311.GA18587@suse.de>
References: <200611061903.09320.m.kozlowski@tuxland.pl> <200611070031.52051.m.kozlowski@tuxland.pl> <20061107002734.GA5236@suse.de> <200611071025.15061.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611071025.15061.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 10:25:14AM +0100, Mariusz Kozlowski wrote:
> Witam, 
> 
> > On Tue, Nov 07, 2006 at 12:31:51AM +0100, Mariusz Kozlowski wrote:
> > > Witam, 
> > > 
> > > > Hello,
> > > > 
> > > > 	There is possible memleak in auerbuf_setup(). Fix is to replace kfree() with auerbuf_free().
> > > > An argument to usb_free_urb() does not need a check as usb_free_urb() already does that. Not sure if I should
> > > > send this in two separate patches. The patch is against 2.6.19-rc4 (not -mm).
> > > 
> > > As I posted the bigger usb_free_urb() patch in another mail this one
> > > should do only one thing which is to fix possible memory leak in
> > > auerbuf_setup().
> > 
> > That is a big patch, care to split it up into smaller pieces like this
> > one so that it is easier to review and apply?
> 
> Sure I can but Andrew already included it in -mm as-is. Do I have to
> prepare another set of patches and send them to you (which is no
> problem to me - just not sure how it works)?

Please just send a new series of patches to me, and then when they show
up in my tree, Andrew will drop his patch.

This will also get you to fix your email client so that you can continue
to send more patches in the future :)

And please CC: usb patches to the linux-usb-devel mailing list, so the
developers there can comment on them if needed.

thanks,

greg k-h
