Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132613AbRA0LDU>; Sat, 27 Jan 2001 06:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRA0LDL>; Sat, 27 Jan 2001 06:03:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:23817 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S131436AbRA0LDG>; Sat, 27 Jan 2001 06:03:06 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101271102.f0RB2we19159@wellhouse.underworld>
Subject: Re: [PATCH](s): Use spinlocks instead of STI/CLI in SoundBlaster
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 27 Jan 2001 22:02:57 +1100 (EST)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20010127112629.B163@bug.ucw.cz> from "Pavel Machek" at Jan 27, 2001 11:26:29 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- linux-2.4.0/drivers/sound/sb.h.orig	Fri Jan 26 13:57:40 2001
> > +++ linux-2.4.0/drivers/sound/sb.h	Fri Jan 26 13:58:42 2001
> > @@ -137,6 +137,8 @@
> >  	   void (*midi_input_intr) (int dev, unsigned char data);
> >  	   void *midi_irq_cookie;		/* IRQ cookie for the midi */
> >  
> > +	   spinlock_t lock;
> > +

I do; that declaration is just a typedef for the device struct. The
spinlock is explicitly initialised in the sb_dsp_detect() function.

Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
