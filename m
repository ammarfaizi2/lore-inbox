Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWHBI7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWHBI7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 04:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHBI7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 04:59:14 -0400
Received: from soundwarez.org ([217.160.171.123]:63385 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932078AbWHBI7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 04:59:14 -0400
Subject: Re: udev taking a long time during startup
From: Kay Sievers <kay.sievers@vrfy.org>
To: piet@bluelane.com
Cc: linux-kernel@vger.kernel.org, piet at work <piet@work.piet.net>
In-Reply-To: <1154416586.4332.64.camel@piet2.bluelane.com>
References: <1154416586.4332.64.camel@piet2.bluelane.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:57:36 +0200
Message-Id: <1154509056.3181.4.camel@min.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 00:16 -0700, Piet Delaney wrote:
> We were wondering why there is a 60 second delay on our systems
> from the time that the kernel releases memory and the file system 
> is checked.
> 
> I dropped into kgdb during this period and found that an init
> script, S10udev in our case, was sleeping in sys_nanosleep()
> or sys_wait4(). Looks like thread/process S10udev forks udevstart
> which forks udev which appears to be sleeping or waiting every time
> I check in on it; Seems terribly wasteful.
> 
> udev seems to be a utility for hotplug and configured
> with /etc/udev/udev.conf. Since we have no hot plug devices
> I wonder if it really has to be called on every startup. On
> solaris the device nodes are only re-established if you boot
> with a -r option.
> 
> I never see any children of udev, so I wonder why it's
> calling wait4() and nanosleep() so often.

You may check with your distro, that sounds like a broken setup. And
please ask further questions on: linux-hotplug-devel@lists.sourceforge.net

Thanks,
Kay

