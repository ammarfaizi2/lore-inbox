Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291431AbSBMH3o>; Wed, 13 Feb 2002 02:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291432AbSBMH3f>; Wed, 13 Feb 2002 02:29:35 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:51728 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291431AbSBMH31>; Wed, 13 Feb 2002 02:29:27 -0500
Date: Wed, 13 Feb 2002 08:29:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Radez <rob@osinvestor.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
Message-ID: <20020213082925.B30588@suse.cz>
In-Reply-To: <20020211220937.GA121@elf.ucw.cz> <Pine.LNX.4.33.0202121758260.26027-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202121758260.26027-100000@pita.lan>; from rob@osinvestor.com on Tue, Feb 12, 2002 at 06:02:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 06:02:16PM -0500, Rob Radez wrote:
> 
> On Mon, 11 Feb 2002, Pavel Machek wrote:
> 
> > Hi!
> >
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
> If you're doing this, would it make sense to get rid of the useless casting
> of the hwgroup member?

Yes, that's also planned.

-- 
Vojtech Pavlik
SuSE Labs
