Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274000AbRISEBd>; Wed, 19 Sep 2001 00:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273998AbRISEBY>; Wed, 19 Sep 2001 00:01:24 -0400
Received: from [24.254.60.24] ([24.254.60.24]:47808 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273997AbRISEBI>; Wed, 19 Sep 2001 00:01:08 -0400
Message-ID: <3BA819C2.35829D39@didntduck.org>
Date: Wed, 19 Sep 2001 00:06:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr> <E15j2BM-0007WU-00@the-village.bc.nu> <20010919044203.A20143@kushida.degree2.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Alan Cox wrote:
> > > The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
> > > Intel (year 2001) mentions that the behaviour of REP is undefined when it
> > > is not used with string opcodes. BTW, according to the same manual, REP is
> > > supposed to modify ecx, but it looks like is is not the case here... which
> > > is fortunate, since ecx is never saved. :-)
> >
> > rep nop is a pentium IV operation. Its retroactively after testing defined
> > to be portable and ok.
> 
> Are we sure that the value of ECX doesn't matter on a 386?  Or does it
> count down doing nops ECX times on a 386?

Older processors ignore the rep prefix when used with non-string
opcodes.  %ecx should not be affected.

--
						Brian Gerst
