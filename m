Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLSVy5>; Tue, 19 Dec 2000 16:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLSVyr>; Tue, 19 Dec 2000 16:54:47 -0500
Received: from [195.163.91.180] ([195.163.91.180]:56074 "EHLO frontpartner.com")
	by vger.kernel.org with ESMTP id <S129523AbQLSVyj>;
	Tue, 19 Dec 2000 16:54:39 -0500
Message-ID: <3A3FD180.FB81D570@linux.se>
Date: Tue, 19 Dec 2000 22:22:08 +0100
From: Mathias Wiklander <eastbay@linux.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx
In-Reply-To: <3A3C2116.46C60CDE@linux.se> <3A3C95B5.7A4D0696@haque.net> <3A3C9A23.553433CA@linux.se> <3A3D2CD3.F68BFC02@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It didn't help me with this patch. The aic7xxx driver (module or
kernelcompiled) just put this 4 rows:

SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.

Anyone who knews what it means? 

I need help.

/Eastbay

> There was a SCSI Makefile bug in test12 that caused
> those unresoved symbols. This patch from Bob Tracy
> fixes it.
> 
> Doug Gilbert
> 
> --- linux/drivers/scsi/Makefile Tue Dec 12 10:49:32 2000
> +++ linux/drivers/scsi/Makefile.t12bt   Tue Dec 12 22:46:27 2000
> @@ -30,7 +30,7 @@
>  CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
>  CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM
>  
> -obj-$(CONFIG_SCSI)             += scsi_mod.o
> +obj-$(CONFIG_SCSI)             += scsi_mod.o scsi_syms.o
>  
>  obj-$(CONFIG_A4000T_SCSI)      += amiga7xx.o   53c7xx.o
>  obj-$(CONFIG_A4091_SCSI)       += amiga7xx.o   53c7xx.o
> @@ -122,8 +122,7 @@
>  scsi_mod-objs  := scsi.o hosts.o scsi_ioctl.o constants.o \
>                         scsicam.o scsi_proc.o scsi_error.o \
>                         scsi_obsolete.o scsi_queue.o scsi_lib.o \
> -                       scsi_merge.o scsi_dma.o scsi_scan.o \
> -                       scsi_syms.o
> +                       scsi_merge.o scsi_dma.o scsi_scan.o
>  
>  sr_mod-objs    := sr.o sr_ioctl.o sr_vendor.o
>  initio-objs    := ini9100u.o i91uscsi.o
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
