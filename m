Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJRJBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJRJBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUJRJBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:01:12 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:27274 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265029AbUJRJAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:00:11 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 18 Oct 2004 10:36:32 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041018083632.GE3065@bytesex>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org> <20041017120728.GC10532@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017120728.GC10532@admingilde.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 02:07:28PM +0200, Martin Waitz wrote:
> hi :)
> 
> On Fri, Oct 15, 2004 at 03:13:13PM +0200, Gerd Knorr wrote:
> > You have a application running which uses the framebuffer device, then
> > suspend with that app running.  You'll have to restore the state of
> > the device _before_ restarting all the userspace proccesses, otherwise
> > the app will not be very happy.
> 
> As long as the app only interfaces with the framebuffer device and not
> directly with the hardware it won't notice.

Well, mmap("/dev/fb") will just map the gfx cards memory into
the applications address space, so they _will_ interface with
the hardware.

> The apps data will simply not show up on the screen until the
> usermode helper finishes.

Whenever writing to the gfx memory before finishing the initialization
is harmless or not probably depends on the hardware, I'd better not
count on it ...

  Gerd

-- 
return -ENOSIG;
