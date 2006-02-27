Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWB0CCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWB0CCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 21:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWB0CCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 21:02:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751000AbWB0CCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 21:02:52 -0500
Date: Mon, 27 Feb 2006 03:02:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060227020238.GA1868@elf.ucw.cz>
References: <200602261721.17373.jesper.juhl@gmail.com> <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com> <20060226193121.GG7851@redhat.com> <200602262043.22463.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602262043.22463.jesper.juhl@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> rand63.log-drivers/built-in.o(.text+0x20ac6): In function `device_suspend':
> rand63.log-drivers/base/power/suspend.c:94: undefined reference to `fg_console'
> rand63.log-drivers/built-in.o(.text+0x20ace):drivers/base/power/suspend.c:94: undefined reference to `vc_cons'
> rand63.log:make: *** [.tmp_vmlinux1] Error 1

Rafael, this one is yours (and mine). We probably need #ifdef
CONFIG_VT or something like that around this code.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
