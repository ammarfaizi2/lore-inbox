Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136213AbRECIJT>; Thu, 3 May 2001 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136216AbRECIJJ>; Thu, 3 May 2001 04:09:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15306 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136213AbRECII4>;
	Thu, 3 May 2001 04:08:56 -0400
Message-ID: <3AF11211.B226543D@mandrakesoft.com>
Date: Thu, 03 May 2001 04:08:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <3AF10E80.63727970@alsa-project.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abramo Bagnara wrote:
> "David S. Miller" wrote:
> > There is a school of thought which believes that:
> >
> > struct xdev_regs {
> >         u32 reg1;
> >         u32 reg2;
> > };
> >
> >         val = readl(&regs->reg2);
> >
> > is cleaner than:
> >
> > #define REG1 0x00
> > #define REG2 0x04
> >
> >         val = readl(regs + REG2);

> The problem I see is that with the former solution nothing prevents from
> to do:
> 
>         regs->reg2 = 13;

Why should there be something to prevent that?

If a programmer does that to an ioremapped area, that is a bug.  Pure
and simple.

We do not need extra mechanisms simply to guard against programmers
doing the wrong thing all the time.


> That's indeed the reason to change ioremap prototype for 2.5.

Say what??

I have heard a good argument from rth about creating a pci_ioremap,
which takes a struct pci_dev argument.  But there is no reason to change
the ioremap prototype.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
