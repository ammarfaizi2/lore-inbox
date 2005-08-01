Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVHATiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVHATiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVHATiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:38:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:59026 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261177AbVHAThN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:37:13 -0400
Date: Mon, 1 Aug 2005 21:37:12 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] remove device_suspend calls in sys_reboot path
Message-ID: <20050801193712.GA30605@suse.de>
References: <200506260105.j5Q15eBj021334@hera.kernel.org> <20050801151956.GA29448@suse.de> <20050801161039.GA29705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050801161039.GA29705@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 01, Olaf Hering wrote:

> 
> A recent change for 'case LINUX_REBOOT_CMD_POWER_OFF' causes an endless
> hang after 'halt -p' on my Macs with USB keyboard.
> It went into rc1, but the hang in an usb device (1-1.3) shows up only
> with rc3. Why is device_suspend() called anyway if the
> system will go down anyway in a few milliseconds?

After reading last weeks sys_reboot thread, I'm not sure if this patch
is correct. But halt -p should work again in 2.6.13, so we need
something. Perhaps USB is broken now.
