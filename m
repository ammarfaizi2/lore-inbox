Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVJ3SWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVJ3SWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVJ3SWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:22:15 -0500
Received: from xenotime.net ([66.160.160.81]:51155 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932189AbVJ3SWP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:22:15 -0500
Date: Sun, 30 Oct 2005 10:22:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Patrick Useldinger <uselpa@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: segmentation fault when accessing /proc/ioports
Message-Id: <20051030102212.679f35db.rdunlap@xenotime.net>
In-Reply-To: <b2992ee70510291004n66537b79h38c6d94005b82cf4@mail.gmail.com>
References: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
	<20051029110358.GI4180@stusta.de>
	<b2992ee70510290422g1912d1e5sedcdf6fc0155c4b0@mail.gmail.com>
	<20051029112617.GJ4180@stusta.de>
	<b2992ee70510290736l7ec43091o880f141bd8be09e7@mail.gmail.com>
	<b2992ee70510291004n66537b79h38c6d94005b82cf4@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005 19:04:39 +0200 Patrick Useldinger wrote:

> This is what I get when I throw out the LVM2 packages
> (device-mapper-1.01.04-i486-1.tgz and lvm2-2.01.09-i486-1.tgz):
> 
> root@slackw:~$ cat /proc/ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 0378-037a : parport0
> 037b-037f : parport0
> 03c0-03df : vesafb
> 03e0-03e1 : $
>              LB D$B$è~'PÇ·D$S%ÿ
> 03f6-03f6 : ide0
> 03f8-03ff : serial
> 0800-0803 : PM1a_EVT_BLK
> 0804-0805 : PM1a_CNT_BLK
> 0808-080b : PM_TMR
> 0816-0816 : PM2_CNT_BLK
> 0820-0823 : GPE0_BLK
> 0830-0833 : GPE1_BLK
> 0c00-0c1f : 0000:00:02.1
>   0c00-0c1f : sis96x-smbus
> 0cf8-0cff : PCI conf1
> 1000-1fff : PCI CardBus #03
> 2000-2fff : PCI CardBus #03
> 3000-3fff : PCI CardBus #07
> 4000-4fff : PCI CardBus #07
> b000-bfff : PCI Bus #01
>   bc00-bc7f : 0000:01:00.0
> d400-d4ff : 0000:00:0f.0
>   d400-d4ff : 8139too
> d800-d87f : 0000:00:02.7
>   d800-d87f : SiS SI7012
> dc00-dcff : 0000:00:02.7
>   dc00-dcff : SiS SI7012
> ff00-ff0f : 0000:00:02.5
>   ff00-ff07 : ide0
>   ff08-ff0f : ide1
> 
> The address at 03e0-03e1 still looks strange, but no more oopses.

Did you perhaps load and unload the (PCMCIA) i82365 driver module?

> ... meaning that the module who produces the problem is dm_mod.
> BTW, I have no VGs on my system.
> Anything else I can do to help tracking the problem?

What's a VG?

---
~Randy
