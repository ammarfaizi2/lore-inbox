Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291236AbSBLXCp>; Tue, 12 Feb 2002 18:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291241AbSBLXCZ>; Tue, 12 Feb 2002 18:02:25 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:51205 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S291236AbSBLXCT>;
	Tue, 12 Feb 2002 18:02:19 -0500
Date: Tue, 12 Feb 2002 18:02:16 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
In-Reply-To: <20020211220937.GA121@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202121758260.26027-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Feb 2002, Pavel Machek wrote:

> Hi!
>
> This is really easy, please apply. (It will allow me to kill few casts
> in future).
> 								Pavel
>
> --- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
> +++ linux-dm/include/linux/ide.h	Mon Feb 11 22:36:12 2002
> @@ -529,7 +531,7 @@
>
>  typedef struct hwif_s {
>  	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
> -	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
> +	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
>  	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
>  	hw_regs_t	hw;		/* Hardware info */
>  	ide_drive_t	drives[MAX_DRIVES];	/* drive info */

If you're doing this, would it make sense to get rid of the useless casting
of the hwgroup member?

Regards,
Rob Radez

