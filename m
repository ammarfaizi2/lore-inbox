Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRL1QQ4>; Fri, 28 Dec 2001 11:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRL1QQq>; Fri, 28 Dec 2001 11:16:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30217 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281772AbRL1QQm>; Fri, 28 Dec 2001 11:16:42 -0500
Subject: Re: [patch] 2.4.17 drivers/scsi/NCR5380.c
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 28 Dec 2001 16:26:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20002.1009513167@ocs3.intra.ocs.com.au> from "Keith Owens" at Dec 28, 2001 03:19:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JzqI-0000xK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Functions in NCR5380.c must be static.  There are a couple of other
> suspect functions but they are conditioned by #ifdef so I left them
> alone.

Im not totally confident the ifdef ones are correct either. The timer one
is definitely correct. Marcelo I guess I'm the nearest thing to NCR5380 
maintainer - please apply this one

> Index: 17.9/drivers/scsi/NCR5380.c
> --- 17.9/drivers/scsi/NCR5380.c Sat, 08 Dec 2001 10:12:02 +1100 kaos (linux-2.4/U/b/0_NCR5380.c 1.4 644)
> +++ 17.9(w)/drivers/scsi/NCR5380.c Fri, 28 Dec 2001 15:15:16 +1100 kaos (linux-2.4/U/b/0_NCR5380.c 1.4 644)
> @@ -612,7 +612,7 @@ static int NCR5380_set_timer(struct Scsi
>   *	Locks: disables irqs, takes and frees io_request_lock
>   */
>   
> -void NCR5380_timer_fn(unsigned long unused)
> +static void NCR5380_timer_fn(unsigned long unused)
>  {
