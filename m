Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVHBKCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVHBKCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVHBJ7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:59:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261467AbVHBJ64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:58:56 -0400
Date: Tue, 2 Aug 2005 11:58:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove device_suspend calls in sys_reboot path
Message-ID: <20050802095836.GA1312@elf.ucw.cz>
References: <200506260105.j5Q15eBj021334@hera.kernel.org> <20050801151956.GA29448@suse.de> <20050801161039.GA29705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801161039.GA29705@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A recent change for 'case LINUX_REBOOT_CMD_POWER_OFF' causes an endless
> hang after 'halt -p' on my Macs with USB keyboard.
> It went into rc1, but the hang in an usb device (1-1.3) shows up only
> with rc3. Why is device_suspend() called anyway if the
> system will go down anyway in a few milliseconds?
> 
> power down works again with this patch.

You are shooting the messenger, and will cause emergency disk
stops. Bad.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
