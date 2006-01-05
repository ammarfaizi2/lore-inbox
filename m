Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWAFDMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWAFDMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWAFDMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:12:01 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:14254 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932624AbWAFDL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:11:59 -0500
Message-ID: <43BD4CB7.4030008@m1k.net>
Date: Thu, 05 Jan 2006 11:43:35 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: takis@issaris.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [PATCH] drivers/media: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060105130229.7E65F6B35@localhost.localdomain>
In-Reply-To: <20060105130229.7E65F6B35@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:

>From: Panagiotis Issaris <takis@issaris.org>
>
>Conversions from kmalloc+memset to k(z|c)alloc.
>
>
>Signed-off-by: Panagiotis Issaris <takis@issaris.org>
>
>---
>
> drivers/media/common/saa7146_core.c               |    9 +++-----
> drivers/media/common/saa7146_fops.c               |    6 ++---
> drivers/media/dvb/b2c2/flexcop.c                  |    6 ++---
> drivers/media/dvb/bt8xx/dvb-bt8xx.c               |    3 +--
> drivers/media/dvb/dvb-core/dvb_ca_en50221.c       |    8 ++-----
> drivers/media/dvb/dvb-core/dvb_frontend.c         |    3 +--
> drivers/media/dvb/dvb-usb/dtt200u-fe.c            |    3 +--
> drivers/media/dvb/dvb-usb/dvb-usb-init.c          |    6 ++---
> drivers/media/dvb/dvb-usb/dvb-usb-urb.c           |    9 +++-----
> drivers/media/dvb/dvb-usb/vp702x-fe.c             |    3 +--
> drivers/media/dvb/dvb-usb/vp7045-fe.c             |    3 +--
> drivers/media/dvb/frontends/bcm3510.c             |    3 +--
> drivers/media/dvb/frontends/dib3000mb.c           |    3 +--
> drivers/media/dvb/frontends/dib3000mc.c           |    3 +--
> drivers/media/dvb/frontends/lgdt330x.c            |    3 +--
> drivers/media/dvb/frontends/mt352.c               |    3 +--
> drivers/media/dvb/frontends/nxt200x.c             |    3 +--
> drivers/media/dvb/pluto2/pluto2.c                 |    3 +--
> drivers/media/dvb/ttpci/av7110.c                  |    4 +---
> drivers/media/dvb/ttpci/budget-av.c               |    4 +---
> drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 +---
> drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    4 +---
> drivers/media/radio/radio-gemtek-pci.c            |    3 +--
> drivers/media/video/adv7170.c                     |    6 ++---
> drivers/media/video/adv7175.c                     |    6 ++---
> drivers/media/video/bt819.c                       |    6 ++---
> drivers/media/video/bt832.c                       |    3 +--
> drivers/media/video/bt856.c                       |    6 ++---
> drivers/media/video/bttv-gpio.c                   |    3 +--
> drivers/media/video/cpia_pp.c                     |    3 +--
> drivers/media/video/cpia_usb.c                    |    4 +---
> drivers/media/video/cs53l32a.c                    |    3 +--
> drivers/media/video/cx25840/cx25840-core.c        |    6 ++---
> drivers/media/video/cx88/cx88-blackbird.c         |    6 ++---
> drivers/media/video/cx88/cx88-core.c              |    3 +--
> drivers/media/video/cx88/cx88-dvb.c               |    3 +--
> drivers/media/video/cx88/cx88-video.c             |    6 ++---
> drivers/media/video/dpc7146.c                     |    3 +--
> drivers/media/video/em28xx/em28xx-video.c         |    3 +--
> drivers/media/video/hexium_gemini.c               |    3 +--
> drivers/media/video/hexium_orion.c                |    3 +--
> drivers/media/video/indycam.c                     |    7 ++----
> drivers/media/video/msp3400.c                     |    3 +--
> drivers/media/video/mxb.c                         |    3 +--
> drivers/media/video/ovcamchip/ov6x20.c            |    3 +--
> drivers/media/video/ovcamchip/ov6x30.c            |    3 +--
> drivers/media/video/ovcamchip/ov76be.c            |    3 +--
> drivers/media/video/ovcamchip/ov7x10.c            |    3 +--
> drivers/media/video/ovcamchip/ov7x20.c            |    3 +--
> drivers/media/video/ovcamchip/ovcamchip_core.c    |    3 +--
> drivers/media/video/saa5246a.c                    |    3 +--
> drivers/media/video/saa5249.c                     |    5 ++--
> drivers/media/video/saa7110.c                     |    6 ++---
> drivers/media/video/saa7111.c                     |    6 ++---
> drivers/media/video/saa7114.c                     |    6 ++---
> drivers/media/video/saa7115.c                     |    6 ++---
> drivers/media/video/saa711x.c                     |    6 ++---
> drivers/media/video/saa7127.c                     |    6 ++---
> drivers/media/video/saa7134/saa6752hs.c           |    3 +--
> drivers/media/video/saa7134/saa7134-core.c        |    3 +--
> drivers/media/video/saa7134/saa7134-video.c       |    3 +--
> drivers/media/video/saa7185.c                     |    6 ++---
> drivers/media/video/saa7191.c                     |    7 ++----
> drivers/media/video/stradis.c                     |    3 +--
> drivers/media/video/tda7432.c                     |    3 +--
> drivers/media/video/tda9875.c                     |    3 +--
> drivers/media/video/tda9887.c                     |    3 +--
> drivers/media/video/tea6420.c                     |    3 +--
> drivers/media/video/tuner-core.c                  |    3 +--
> drivers/media/video/tvaudio.c                     |    3 +--
> drivers/media/video/tveeprom.c                    |    6 ++---
> drivers/media/video/tvp5150.c                     |    3 +--
> drivers/media/video/v4l1-compat.c                 |   24 +++++++--------------
> drivers/media/video/video-buf.c                   |    9 +++-----
> drivers/media/video/videocodec.c                  |   11 ++--------
> drivers/media/video/videodev.c                    |    5 +---
> drivers/media/video/vino.c                        |    4 +---
> drivers/media/video/vpx3220.c                     |    7 ++----
> drivers/media/video/wm8775.c                      |    3 +--
> drivers/media/video/zoran_card.c                  |    3 +--
> drivers/media/video/zoran_driver.c                |    3 +--
> drivers/media/video/zr36016.c                     |    3 +--
> drivers/media/video/zr36050.c                     |    3 +--
> drivers/media/video/zr36060.c                     |    3 +--
> 84 files changed, 121 insertions(+), 259 deletions(-)
>  
>
It is very wrong of you to assume that every subsystem maintainer is 
current on LKML...  In the future, please cc Linux and Kernel Video 
<video4linux-list@redhat.com> and / or Mauro Carvalho Chehab 
<mchehab@infradead.org> + Johannes Stezenbach <js@linuxtv.org>  
(official v4l / dvb subsystem maintainers)  with all patches to v4l / 
dvb subsystems.

This information IS in the MAINTAINERS file.

For those whose cc's I added, please see original patch, located at:

http://lkml.org/lkml/2006/1/5/77

Regards,

Michael Krufky


