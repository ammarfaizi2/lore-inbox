Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUDZNKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUDZNKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUDZNKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:10:09 -0400
Received: from linux-bt.org ([217.160.111.169]:664 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261298AbUDZNKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:10:05 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <200404260732.46315.dtor_core@ameritech.net>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <20040425235844.E13748@flint.arm.linux.org.uk>
	 <1082975742.28880.120.camel@pegasus>
	 <200404260732.46315.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1082984991.28880.145.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 15:09:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> This is wrong... What if you have several devices that are needed firmware?
> You are not only loading a specific firmware but do it for a specific device.
> You may also want to do something else with it...
> 
> I think until pcmcia either provides or allows to create devices on pcmcia
> bus you can just fixup the name breakage like I did for atmel driver and
> leave it be. The device is not registered and not used in any way except to
> provide "unique" name for fimrware loader, at list in atmel_cs that is the
> case.

as you said the only real goal of the device in request_firmware() is to
provide us with a unique path to the "loading" and "data" files. The
advantage of having the device linked is currently not used by the
firmware.agent script and I don't think that it ever will be used.
However you can take a look at 2.4, where the device parameter is only a
string. So what is wrong with letting request_firmware() create a dummy
and temporary device that is not related to any hardware?

Regards

Marcel


