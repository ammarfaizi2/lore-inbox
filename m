Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWHCQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWHCQaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWHCQaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:30:20 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:56799 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964841AbWHCQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:30:19 -0400
Date: Thu, 3 Aug 2006 09:30:18 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell3.speakeasy.net
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org,
       v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       b.buschinski@web.de
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] DVB_CORE must select I2C
In-Reply-To: <20060803155925.GA25692@stusta.de>
Message-ID: <Pine.LNX.4.58.0608030918240.4264@shell3.speakeasy.net>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060803155925.GA25692@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Adrian Bunk wrote:
> On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc2-mm1:
> >...
> > +dvb-core-needs-i2c.patch
> >...
> >  DVB fixes
> >...
>
> This means people who observed a compile error will now have the DVB
> support silently removed from their kernel.

This has been fixed differently already.  dvb-core.ko doesn't actually use
I2C, only dvb-pll.ko does.  Now the dvb-pll.ko module is no longer turned
on by DVB_CORE, but under a new option, DVB_PLL.  That option depends on
I2C.

