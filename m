Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031272AbWLEUVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031272AbWLEUVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031303AbWLEUVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:21:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52790 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031272AbWLEUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:21:07 -0500
Date: Tue, 5 Dec 2006 12:20:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061205122057.c2b617f4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
	<20061205100140.24888a96.akpm@osdl.org>
	<Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
	<20061205114310.e85d4c7e.akpm@osdl.org>
	<Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 19:59:01 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> 
> > > > > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > > > > 
> > > > > Does this patch update the fbdev drivers?
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > > > 
> > > > Seems not.  Should it?
> > > 
> > > Yes. Its bizarre.
> > 
> > It is.
> > 
> > > The drivers compile with the wrong method prototype.
> > 
> > No, it doesn't get compiled at all.
> > 
> > CONFIG_FB_ATY128_BACKLIGHT has no Kconfig record at all.
> > 
> > CONFIG_FB_NVIDIA_BACKLIGHT has no Kconfig record at all.
> > 
> > CONFIG_FB_RIVA_BACKLIGHT has no Kconfig record at all.
> > 
> > So this is all dead code.  There is no way to enable any of it within the
> > config system.
> 
> Ug. Kconfig in drivers/video has all the above drivers enable the 
> backlight only if PMAC_BACKLIGHT is set.

erp, I grepped for CONFIG_foo and not foo.  Again.

> The problem is backlight
> is after the framebuffer. We should move the backlight menu before
> the framebuffer configuration.

OK.  Can you do a patch sometime please?
