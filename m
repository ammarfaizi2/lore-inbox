Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSFDXlv>; Tue, 4 Jun 2002 19:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317501AbSFDXlu>; Tue, 4 Jun 2002 19:41:50 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:52468 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317500AbSFDXlu>;
	Tue, 4 Jun 2002 19:41:50 -0400
Date: Wed, 5 Jun 2002 01:41:46 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Robert Cardell <rbt@mtlb.co.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Trivial, IDE geometry fix / defconfig changes
Message-ID: <20020604234146.GA7255@win.tue.nl>
In-Reply-To: <20020604215617.A288@garfield.mtlb.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 09:56:17PM +0100, Robert Cardell wrote:

> --- ide-disk.c.old	Tue Jun  4 21:09:10 2002
> +++ ide-disk.c	Tue Jun  4 21:09:44 2002
> @@ -929,9 +929,9 @@
>  
>  	if (id->cfs_enable_2 & 0x0400) {
>  		capacity_2 = id->lba_capacity_2;
> -		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
>  		drive->head		= drive->bios_head = 255;
>  		drive->sect		= drive->bios_sect = 63;
> +		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
>  		drive->select.b.lba	= 1;
>  		set_max_ext = idedisk_read_native_max_address_ext(drive);
>  		if (set_max_ext > capacity_2) {
> 

Yes, let me confirm: this patch is required.
I sent it to the list on 10 Feb 2002 ("[PATCH] tiny IDE fixes"); apparently
nobody picked it up, or at least it didnt reach 2.4.19-pre9 yet.
That patch also removed some dead code.

Andries
