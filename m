Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbRECIkc>; Thu, 3 May 2001 04:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136244AbRECIkW>; Thu, 3 May 2001 04:40:22 -0400
Received: from smtp2.libero.it ([193.70.192.52]:62121 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S136240AbRECIkG>;
	Thu, 3 May 2001 04:40:06 -0400
Message-ID: <3AF11953.54BBE72B@alsa-project.org>
Date: Thu, 03 May 2001 10:39:47 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <3AF10E80.63727970@alsa-project.org> <3AF11211.B226543D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Abramo Bagnara wrote:
> > "David S. Miller" wrote:
> > > There is a school of thought which believes that:
> > >
> > > struct xdev_regs {
> > >         u32 reg1;
> > >         u32 reg2;
> > > };
> > >
> > >         val = readl(&regs->reg2);
> > >
> > > is cleaner than:
> > >
> > > #define REG1 0x00
> > > #define REG2 0x04
> > >
> > >         val = readl(regs + REG2);
> 
> > The problem I see is that with the former solution nothing prevents from
> > to do:
> >
> >         regs->reg2 = 13;
> 
> Why should there be something to prevent that?
> 
> If a programmer does that to an ioremapped area, that is a bug.  Pure
> and simple.
> 
> We do not need extra mechanisms simply to guard against programmers
> doing the wrong thing all the time.
>
> > That's indeed the reason to change ioremap prototype for 2.5.
> 
> Say what??
> 

Please give a look
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0338.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0407.html

This was something that already got a wide consent.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
