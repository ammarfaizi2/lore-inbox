Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSBMTi5>; Wed, 13 Feb 2002 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSBMTir>; Wed, 13 Feb 2002 14:38:47 -0500
Received: from femail13.sdc1.sfba.home.com ([24.0.95.140]:60588 "EHLO
	femail13.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288800AbSBMTig>; Wed, 13 Feb 2002 14:38:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
Date: Wed, 13 Feb 2002 14:39:28 -0500
X-Mailer: KMail [version 1.3.1]
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211220937.GA121@elf.ucw.cz> <20020212224930.OKGN9845.femail25.sdc1.sfba.home.com@there> <20020213104731.GG32687@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020213104731.GG32687@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020213193835.CIGI23450.femail13.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 05:47 am, Pavel Machek wrote:
> Hi!
>
> > > This is really easy, please apply. (It will allow me to kill few casts
> > > in future).
> > > 								Pavel
> > >
> > > --- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
> > > +++ linux-dm/include/linux/ide.h	Mon Feb 11 22:36:12 2002
> > > @@ -529,7 +531,7 @@
> > >
> > >  typedef struct hwif_s {
> > >  	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
> > > -	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
> > > +	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
> > >  	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
> > >  	hw_regs_t	hw;		/* Hardware info */
> > >  	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
> >
> > Now I'm confused about the comment on the end of the line.
> >
> > Should the comment be changed, or should the type be ide_hwgroup_t
> > instead of struct hwgroup_s?
>
> struct hwgroup_s == ide_hwgroup_t. That's infection by hungarian
> notation, and yes it would be nice to clean it up. For now, I'm
> killing worst stuff.
> 							Pavel

I know they're functionally equivalent, but so was the original void *. :)

Just an "as long as you're touching this line anyway, why leave the old 
comment?" thing.  A minor, in-passing nit at best...

Rob
