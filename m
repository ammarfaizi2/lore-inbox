Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFPQrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 12:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTFPQrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 12:47:47 -0400
Received: from intranet.resilience.com ([12.36.124.2]:28080 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id S264023AbTFPQrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 12:47:46 -0400
Mime-Version: 1.0
Message-Id: <p05210616bb13a7f728e0@[207.213.214.37]>
In-Reply-To: <20030616142340.GA369@elf.ucw.cz>
References: <20030616142340.GA369@elf.ucw.cz>
Date: Mon, 16 Jun 2003 10:01:35 -0700
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: i8253 != rtc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:23pm +0200 6/16/03, Pavel Machek wrote:
>  /* XXX this driverfs stuff should probably go elsewhere later -john
>*/
>  static struct sys_device device_i8253 = {
>-       .name           = "rtc",
>         .id             = 0,
>-       .dev    = {
>-               .name   = "i8253 Real Time Clock",
>-       },
>+       .cls    = &rtc_sysclass,
>  };
>
>...but i8253 is *not* real time clock. Its clock since
>bootup. Realtime clock is near battery-backed CMOS RAM, its driver is
>linux/drivers/char/rtc.c...

FWIW, the legacy Intel databooks call it a "Programmable Interval 
Timer" (PIT). Likewise the 8254, a superset of the 8253. I don't know 
that Intel ever used the 'i' prefix on these parts.
-- 
/Jonathan Lundell.
