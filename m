Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbUA1AlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUA1AlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:41:08 -0500
Received: from smtp.infonegocio.com ([213.4.129.150]:15067 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S263891AbUA1AlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:41:05 -0500
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: Kiko Piris <kernel@pirispons.net>
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Date: Wed, 28 Jan 2004 01:39:51 +0100
User-Agent: KMail/1.5.4
Cc: Zack Winkles <winkie@linuxfromscratch.org>, linux-kernel@vger.kernel.org
References: <200401270153.12568.DXpublica@telefonica.net> <200401271859.03309.DXpublica@telefonica.net> <20040127225909.GA5271@sacarino.pirispons.net>
In-Reply-To: <20040127225909.GA5271@sacarino.pirispons.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401280139.51712.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works finally. I don't know if with vesafb or with radeon, but it works.

In my old .config file I have:
cat /usr/src/linux-2.6.1/linux18-pre6 | grep ^CONFIG | egrep -i "fb|radeon|
console"
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_DRM_RADEON=m
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_RADEON=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y

now, I have the following:
 cat /usr/src/linux-2.6.1/linux18-pre7 | grep ^CONFIG | egrep -i "fb|radeon|
console"
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_DRM_RADEON=m
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_RADEON=m
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y

I suspect that it's because Frame buffer console is y and not m. But perhaps 
it's Sis too.

Regards to all,
Xan.

