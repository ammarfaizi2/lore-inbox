Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291225AbSBLWty>; Tue, 12 Feb 2002 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291232AbSBLWto>; Tue, 12 Feb 2002 17:49:44 -0500
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:41185 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S291225AbSBLWtc>; Tue, 12 Feb 2002 17:49:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
Date: Tue, 12 Feb 2002 17:50:23 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020211220937.GA121@elf.ucw.cz>
In-Reply-To: <20020211220937.GA121@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020212224930.OKGN9845.femail25.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 February 2002 05:09 pm, Pavel Machek wrote:
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

Now I'm confused about the comment on the end of the line.

Should the comment be changed, or should the type be ide_hwgroup_t instead of 
struct hwgroup_s?

Rob
