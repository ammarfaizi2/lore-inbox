Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVKTPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVKTPrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVKTPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:47:41 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:50049 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751260AbVKTPrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:47:40 -0500
Subject: Re: [2.6 patch] drivers/media/video/: make code static
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051120024432.GV16060@stusta.de>
References: <20051120024432.GV16060@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 20 Nov 2005 13:47:23 -0200
Message-Id: <1132501643.24952.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

Em Dom, 2005-11-20 às 03:44 +0100, Adrian Bunk escreveu:
> This patch makes needlessly global code static.
> 
> 
>  drivers/media/video/bttv-cards.c           |    6 +++---
>  drivers/media/video/cx25840/cx25840-core.c |    4 ++--
>  drivers/media/video/em28xx/em28xx-core.c   |    6 +++---
>  drivers/media/video/em28xx/em28xx-video.c  |    2 +-
>  drivers/media/video/saa7127.c              |    6 +++---
>  drivers/media/video/saa7134/saa7134-alsa.c |    9 +++++----
>  drivers/media/video/saa7134/saa7134-oss.c  |    4 ++--
>  7 files changed, 19 insertions(+), 18 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Thanks for your patch.

> --- linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-alsa.c.old	2005-11-20 02:49:12.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-alsa.c	2005-11-20 02:58:01.000000000 +0100
> @@ -58,7 +58,7 @@
>  module_param_array(index, int, NULL, 0444);
>  MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
>  
> -int position;
> +static int position;

	This didn't applied at V4L tree. This flag was removed at the latest
version. We had already a patch including static on some I2C structs and
other trivial fixes.
I'll added your patch with fixes on my tree and send to -mm in the next
V4L patchsets, after the patch that removes position and fixes some
stuff at saa7134-alsa.

Cheers, 
Mauro.

