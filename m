Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUI2Xyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUI2Xyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUI2Xyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:54:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:15579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269203AbUI2Xyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:54:32 -0400
Date: Wed, 29 Sep 2004 16:53:53 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: patrakov@ums.usu.ru, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040929235353.GA27192@kroah.com>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <cikaf1$e60$1@sea.gmane.org> <20040919173035.GA2345@kroah.com> <20040929163828.4d06010b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929163828.4d06010b.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:38:28PM -0700, Randy.Dunlap wrote:
> On Sun, 19 Sep 2004 10:30:35 -0700 Greg KH wrote:
> 
> | On Sun, Sep 19, 2004 at 10:00:52PM +0600, Alexander E. Patrakov wrote:
> | > 
> | > OK. The fact is that, when mounting the root filesystem, the kernel can 
> | > (?) definitely say "there is no such device, and it's useless to wait 
> | > for it--so I panic". Is it possible to duplicate this logic in the case 
> | > with udev and modprobe? If so, it should be built into a common place 
> | > (either the kernel or into modprobe), but not into all apps.
> | 
> | No, we need to just change the kernel to sit and spin for a while if the
> | root partition is not found.  This is the main problem right now for
> | booting off of a USB device (or any other "slow" to discover device.)
> | It's a known kernel issue, and there are patches for 2.4 for this, but
> | no one has taken the time to update them for 2.6.
> 
> (I'm way behind, and I was hoping this thread would die, but:)
> 
> I've seen 2.6 patches for booting from USB or IEEE1394.

Where?

> Is there a fair chance of getting something for USB/1394 booting
> merged?  (other than by using initrd)

I want to see this work, as lots of people bug me about this when I meet
them with the comment, "Oh, you're the USB maintainer, how come I can't
boot off of my USB flash key," which causes me to turn and run away very
fast...

thanks,

greg k-h
