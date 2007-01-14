Return-Path: <linux-kernel-owner+w=401wt.eu-S1750771AbXANA3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbXANA3o (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbXANA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:29:44 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40567 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbXANA3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:29:43 -0500
Message-ID: <45A9797F.9000806@drzeus.cx>
Date: Sun, 14 Jan 2007 01:29:51 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: No more "device" symlinks for classes
References: <45A97089.5090004@drzeus.cx> <1168732961.14924.39.camel@pim.off.vrfy.org>
In-Reply-To: <1168732961.14924.39.camel@pim.off.vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
>
> The plan is to have a single unified tree at /sys/devices, where all
> device-directories live below their parents, and /sys/class contains
> only symlinks pointing into this single tree, just like /sys/bus.
>
> People want to stack class-devices, but this leads to a /sys/devices
> tree and several small trees spread around in /sys/class. These trees
> need to be connected by "device"-links and the "class:"-links, which
> just doesn't make much sense if you can have one single tree with the
> same information.
>
> In the unified tree, the "device"-link will always just point to the
> parent device, that's why there is a config option to disable these
> links and test current software not to depend on it.
>
>   

I'm not sure I completely follow. Should an application look at the
symlink (e.g. /sys/class/fooclass/foodev -> /sys/devices/...) and follow
that one level up? If so, then this sounds a bit complicated. Especially
from shell scripts.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

