Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTF0Obk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTF0Obk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:31:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13037 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264396AbTF0Obc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:31:32 -0400
Date: Fri, 27 Jun 2003 16:45:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Kees Bakker <kees.bakker@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_core.c -Werror causes build to stop
Message-ID: <20030627144540.GG24661@fs.tum.de>
References: <sillvnomds.fsf@koli.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sillvnomds.fsf@koli.tasking.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 12:17:19PM +0200, Kees Bakker wrote:
> To build 2.5.73 using my SuSE 8.2 system (gcc 3.3) I need the following
> patch:
> 
> --- linux-2.5.73/drivers/scsi/aic7xxx/Makefile.orig	2003-06-22 20:33:34.000000000 +0200
> +++ linux-2.5.73/drivers/scsi/aic7xxx/Makefile	2003-06-27 10:38:40.000000000 +0200
> @@ -33,7 +33,7 @@
>  						   aic79xx_proc.o	\
>  						   aic79xx_osm_pci.o
>  
> -EXTRA_CFLAGS += -Idrivers/scsi -Werror
> +EXTRA_CFLAGS += -Idrivers/scsi -Werror -Wno-sign-compare
>  #EXTRA_CFLAGS += -g
>  
>  # Files generated that shall be removed upon make clean
>...

The -Wno-sign-compare is not needed with the official gcc 3.3 release. 
It's only needed for beta versions of gcc 3.3 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

