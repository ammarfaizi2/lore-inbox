Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVAHWNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVAHWNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVAHWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:10:09 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:16920 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261924AbVAHWJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:09:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gEkLKx/wvuJbQO3Cb5QZiMhovY6R8l61rke13qG6r+Lzq8lU3CXQpFqraYOvJ/HtVKceSm7S0LCke65XerPZhuajF9h0PCexX7HcV7NB9QgCsgsd+uTRPseoeCwJA4ML+GnnqfLpOzzVq9AHHXcSzCtz628XslHVP3u4T1ouWKw=
Message-ID: <58cb370e05010814097c8ae8d9@mail.gmail.com>
Date: Sat, 8 Jan 2005 23:09:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] ide-scsi.c: make 2 functions static (fwd) (fwd)
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050108214008.GT14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050108214008.GT14108@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005 22:40:08 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> The patch forwarded below still applies and compiles against 2.6.10-mm2.

hmm, latest IDE update (in -bk) also makes these functions static

> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c.old       2004-11-13 21:51:26.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c   2004-11-13 21:51:41.000000000 +0100
> @@ -301,7 +301,7 @@
>         return ide_do_drive_cmd(drive, rq, ide_preempt);
>  }
> 
> -ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
> +static ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
>  {
>         struct request *rq;
>         byte err;
> @@ -327,7 +327,7 @@
>         return ide_stopped;
>  }
> 
> -ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
> +static ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
>  {
>         struct request *rq;
>
