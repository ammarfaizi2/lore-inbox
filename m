Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSJLRhE>; Sat, 12 Oct 2002 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJLRhE>; Sat, 12 Oct 2002 13:37:04 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:54543 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261311AbSJLRhE>; Sat, 12 Oct 2002 13:37:04 -0400
Date: Sat, 12 Oct 2002 14:42:40 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Art Haas <ahaas@neosoft.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] C99 designated initializers for drivers/scsi
Message-ID: <20021012174240.GA5259@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Art Haas <ahaas@neosoft.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
References: <20021012165901.GK633@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012165901.GK633@debian>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 12, 2002 at 11:59:01AM -0500, Art Haas escreveu:
> 
> Art Haas
> 
> --- linux-2.5.42/drivers/scsi/ide-scsi.c.old	2002-10-12 09:46:55.000000000 -0500
> +++ linux-2.5.42/drivers/scsi/ide-scsi.c	2002-10-12 09:51:32.000000000 -0500
> @@ -574,29 +574,29 @@
>   *	IDE subdriver functions, registered with ide.c
>   */
>  static ide_driver_t idescsi_driver = {
> +	.busy			= 0,
> +	.supports_dsc_overlap	= 0,
> +	.standby		= NULL,
> +	.flushcache		= NULL,
> +	.media_change		= NULL,
> +	.revalidate		= NULL,
> +	.pre_reset		= NULL,
> +	.capacity		= NULL,
> +	.special		= NULL,
> +	.proc			= NULL,

Art, I suggest that you simply delete the lines that initializes to 0 or NULL,
as the compiler will take care of zeroing it and the source code gets a bit
smaller.

- Arnaldo
