Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWLETnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWLETnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWLETnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:43:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46467 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030478AbWLETnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:43:21 -0500
Date: Tue, 5 Dec 2006 11:43:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061205114310.e85d4c7e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
	<20061205100140.24888a96.akpm@osdl.org>
	<Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 18:25:58 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> > > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > > 
> > > Does this patch update the fbdev drivers?
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > 
> > Seems not.  Should it?
> 
> Yes. Its bizarre.

It is.

> The drivers compile with the wrong method prototype.

No, it doesn't get compiled at all.

CONFIG_FB_ATY128_BACKLIGHT has no Kconfig record at all.

CONFIG_FB_NVIDIA_BACKLIGHT has no Kconfig record at all.

CONFIG_FB_RIVA_BACKLIGHT has no Kconfig record at all.

So this is all dead code.  There is no way to enable any of it within the
config system.

> I 
> updated the fbdev drivers to the new backlight_device_register and it 
> compiled as expect. There are a few other problems with teh fbdev drivers. 
> I will send a patch.

It's a start ;)
