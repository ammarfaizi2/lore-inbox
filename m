Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVKTTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVKTTNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVKTTND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:13:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:64426 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932067AbVKTTNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:13:02 -0500
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Linux 2.6.15-rc2
Date: Sun, 20 Nov 2005 20:13:00 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511201420.55062.warpy@gmx.de> <200511201113.29911.dtor_core@ameritech.net>
In-Reply-To: <200511201113.29911.dtor_core@ameritech.net>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202013.00879.warpy@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 20 November 2005 17:13, you wrote:
> On Sunday 20 November 2005 08:20, Michael Geithe wrote:
> > Hi,
> > i get this after plugged in dvb-t/Cinergy T2 with Kernel 2.6.15-git*/rc*.
>
> Hm, is there one driver in drivers/media that I left working? Please
> try the patch below.

> Subjtect: Fix an OOPS is CinergyT2

> Fix an OOPS is CinergyT2 driver when registering IR remote

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


>  drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)

>  Index: work/drivers/media/dvb/cinergyT2/cinergyT2.c
>  ===================================================================
>  --- work.orig/drivers/media/dvb/cinergyT2/cinergyT2.c
>  +++ work/drivers/media/dvb/cinergyT2/cinergyT2.c
>  @@ -772,7 +772,7 @@ static int cinergyt2_register_rc(struct 
>          input_dev->name = DRIVER_NAME " remote control";
>          input_dev->phys = cinergyt2->phys;
>          input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
>  -       for (i = 0; ARRAY_SIZE(rc_keys); i += 3)
>  +       for (i = 0; i < ARRAY_SIZE(rc_keys); i += 3)
>                  set_bit(rc_keys[i + 2], input_dev->keybit);
>          input_dev->keycodesize = 0;
>          input_dev->keycodemax = 0;

Thanks,  it works. :-)

M. Geithe
-
