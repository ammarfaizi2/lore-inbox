Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291578AbSBAHPI>; Fri, 1 Feb 2002 02:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291579AbSBAHO6>; Fri, 1 Feb 2002 02:14:58 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:40461 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291578AbSBAHOo>; Fri, 1 Feb 2002 02:14:44 -0500
Date: Fri, 1 Feb 2002 08:14:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@transvirtual.com>, Vojtech Pavlik <vojtech@ucw.cz>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
Message-ID: <20020201081442.G15571@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10201310712130.20956-100000@www.transvirtual.com> <Pine.GSO.4.21.0201312153250.24581-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201312153250.24581-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Jan 31, 2002 at 09:54:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:54:51PM +0100, Geert Uytterhoeven wrote:
> On Thu, 31 Jan 2002, James Simmons wrote:
> >   The amiga mouse and amiga joystick have been already ported over to the
> > input api. Now for the keyboard. This patch is the input api amiga
> > keyboard. I wanted people to try it out before I send it off to be
> > included in the DJ tree. Have fun!!!
> 
> > diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c linux/drivers/input/keyboard/amikbd.c
> > --- linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c	Wed Dec 31 16:00:00 1969
> > +++ linux/drivers/input/keyboard/amikbd.c	Thu Jan 31 07:44:05 2002
> 
> > +static char *amikbd_messages[] = {
> > +	KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
> > +	KERN_WARNING "amikbd: keyboard lost sync\n",
> > +	KERN_WARNING "amikbd: keyboard buffer overflow\n",
> > +	KERN_WARNING "amikbd: keyboard controller failure\n",
> > +	KERN_ERR "amikbd: keyboard selftest failure\n",
> > +	KERN_INFO "amikbd: initiate power-up key stream\n",
> > +	KERN_INFO "amikbd: terminate power-up key stream\n",
> > +	KERN_WARNING "amikbd: keyboard interrupt\n"
> > +};
> 
> > +	if (scancode < 0x78) {		/* scancodes < 0x78 are keys */
> 
>   [...]
> 
> > +	}
> > +
> > +	printk(amikbd_messages[scancode]);	/* scancodes >= 0x78 are error codes */
> 
> Oops, amikbd_messages[scancode-0x78]?

Thanks. And thanks to James for fixing this in the CVS as well.
Does it work otherwise?

-- 
Vojtech Pavlik
SuSE Labs
