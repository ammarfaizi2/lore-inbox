Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbTERJi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbTERJi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:38:57 -0400
Received: from a4.veijo.ton.tut.fi ([193.166.236.20]:18091 "EHLO
	butthead.ton.tut.fi") by vger.kernel.org with ESMTP id S262007AbTERJi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:38:56 -0400
From: Sami Nieminen <sami.nieminen@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [drm:radeon_unlock] *ERROR* Process 2421 using kernel context 0
Date: Sun, 18 May 2003 12:51:50 +0300
User-Agent: KMail/1.5.9
References: <200305181232.38724.sami.nieminen@iki.fi>
In-Reply-To: <200305181232.38724.sami.nieminen@iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305181251.50678.sami.nieminen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the error showed in the subject with my ATi 7500 Radeon
>
> I am not sure if this is the correct place but as the error says kernel
> context I am writing here.
>
>
> Well, afer that error shows itself in the output of dmesg, the console
> freezes, and I can only access my box using a remote station and telnet or
> ssh

Hi,

I have had the same error (except that my console does not freeze, direct 
rendering is just disabled) since I updated my hotplug scripts to 20030501 
version. If I go back to 20030826 version, this error does not appear and 
direct rendering is working fine. I have tested with 2.5.69 and 2.5.69-bk12 
at least. Hardware is Radeon Mobility 9000 and I am using the radeon driver 
from XFree 4.3.0. BTW, my distribution is Gentoo, which adds some patches on 
top of hotplug. Here is the error from my dmesg output:

Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized radeon 1.8.0 20020828 on minor 0
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 3677 using kernel context 0

And then from XFree log:

drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
[drm] failed to load kernel module "agpgart"
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe08d8000
(II) RADEON(0): [drm] mapped SAREA 0xe08d8000 to 0x40013000
(II) RADEON(0): [drm] framebuffer handle = 0xf0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(WW) RADEON(0): [agp] AGP not available
(II) RADEON(0): [drm] removed 1 reserved context for kernel
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xe08d8000 at 0x40013000

Best regards, Sami

P.S. Please CC me any answers/comments as I am not subscribed to the list, 
thanks!

-- 
Linux 2.5.69-bk12
