Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284573AbRLIWhR>; Sun, 9 Dec 2001 17:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284576AbRLIWhI>; Sun, 9 Dec 2001 17:37:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4114 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284573AbRLIWg7>; Sun, 9 Dec 2001 17:36:59 -0500
Subject: Re: Linux 2.4.17-pre7 - fdomain_stub.c error
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sun, 9 Dec 2001 22:45:59 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C13E25C.5E323277@eyal.emu.id.au> from "Eyal Lebedinsky" at Dec 10, 2001 09:14:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DChr-00084g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux/drivers/scsi/pcmcia/fdomain_stub.c does not compile. I think
> this is the fix.

Looks right to me - I missed the pcmcia driver 

> 
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
> --------------8026A2A24BDB50E5447F0468
> Content-Type: text/plain; charset=us-ascii;
>  name="2.4.17-pre7-fdomain.patch"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline;
>  filename="2.4.17-pre7-fdomain.patch"
> 
> --- linux/drivers/scsi/fdomain.h.orig	Mon Dec 10 09:09:28 2001
> +++ linux/drivers/scsi/fdomain.h	Mon Dec 10 09:10:14 2001
> @@ -34,6 +34,7 @@
>  int        fdomain_16x0_biosparam( Disk *, kdev_t, int * );
>  int        fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
>  				   int length, int hostno, int inout );
> +int        fdomain_16x0_release( struct Scsi_Host *shpnt );
>  
>  #define FDOMAIN_16X0 { proc_info:      fdomain_16x0_proc_info,           \
>  		       detect:         fdomain_16x0_detect,              \
> 
> --------------8026A2A24BDB50E5447F0468--
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

