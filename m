Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbQKDI2E>; Sat, 4 Nov 2000 03:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbQKDI1y>; Sat, 4 Nov 2000 03:27:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2828 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S132582AbQKDI1j>;
	Sat, 4 Nov 2000 03:27:39 -0500
Message-ID: <3A03C836.3A813A2A@mandrakesoft.com>
Date: Sat, 04 Nov 2000 03:26:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9
In-Reply-To: <Pine.LNX.3.95.1001103213717.2705A-100000@chaos.analogic.com> <3A037E9F.55B16633@mandrakesoft.com> <20001104092049.W7204@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Fri, Nov 03, 2000 at 10:12:31PM -0500, Jeff Garzik wrote:
> > But if you are going to eliminate info->vxi_base, it seems like that
> > would flush out all direct de-refs, whether they are buried in an
> > obscure macro or not.  And if you find all that crap, you might as well
> > use readb/writel at that point...
> >
> >       info->registers[0x7FF] = newvalue;
> >               becomes
> >       writel(newvalue, &info->registers[0x7FF]);
> > and
> >       regval = info->registers[0x7FF];
> >               becomes
> >       regval = readl(&info->registers[0x7FF]);
> 
> Wasn't this the clean and recommended interface anyway?
> (ref. IO-mapping.txt:150)

Absolutely!  We are talking about an old driver, though, and due
consideration has to be given to not breaking existing code :)

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
