Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLIJrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLIJqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:46:33 -0500
Received: from quechua.inka.de ([193.197.184.2]:17343 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264329AbTLIJpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:45:38 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 10:46:28 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.09.09.46.27.327988@dungeon.inka.de>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <3FD577E7.9040809@nishanet.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe add this to the faq?

Q: devfs did load drivers when someone tried to open() a non existing
device. will sysfs/hotplug/udev do this?

A: there is no need to. hotplug/sysfs/udev will create devices for all
hardware supported by the kernel and the available modules. it will do
that during boot up, and whenever new hardware is added. so you can expect
all devices be already present, no need for a devfs like mechanism.

Q: but what if a device is still missing?
A: in that case neither the linux kernel nor the available modules support
that hardware, so there is nothing hotplug/sysfs/udev can do about it.
If you add modules and [FIXME: how to update the module maps] and
[FIXME: remove and attach again or do ... to spawn hotplug events] the
kernel will load the modules and udev will create the device files.


Andreas

