Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291543AbSBMKrx>; Wed, 13 Feb 2002 05:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBMKro>; Wed, 13 Feb 2002 05:47:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37126 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S291543AbSBMKrh>; Wed, 13 Feb 2002 05:47:37 -0500
Date: Wed, 13 Feb 2002 11:47:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <landley@trommello.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
Message-ID: <20020213104731.GG32687@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020211220937.GA121@elf.ucw.cz> <20020212224930.OKGN9845.femail25.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212224930.OKGN9845.femail25.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is really easy, please apply. (It will allow me to kill few casts
> > in future).
> > 								Pavel
> >
> > --- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
> > +++ linux-dm/include/linux/ide.h	Mon Feb 11 22:36:12 2002
> > @@ -529,7 +531,7 @@
> >
> >  typedef struct hwif_s {
> >  	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
> > -	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
> > +	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
> >  	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
> >  	hw_regs_t	hw;		/* Hardware info */
> >  	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
> 
> Now I'm confused about the comment on the end of the line.
> 
> Should the comment be changed, or should the type be ide_hwgroup_t instead of 
> struct hwgroup_s?

struct hwgroup_s == ide_hwgroup_t. That's infection by hungarian
notation, and yes it would be nice to clean it up. For now, I'm
killing worst stuff.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
