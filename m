Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRISDmT>; Tue, 18 Sep 2001 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272983AbRISDmA>; Tue, 18 Sep 2001 23:42:00 -0400
Received: from pc-62-30-67-108-az.blueyonder.co.uk ([62.30.67.108]:56814 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272493AbRISDl4>; Tue, 18 Sep 2001 23:41:56 -0400
Date: Wed, 19 Sep 2001 04:42:03 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, linux-kernel@vger.kernel.org,
        linux-smp@vger.kernel.org
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
Message-ID: <20010919044203.A20143@kushida.degree2.com>
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr> <E15j2BM-0007WU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15j2BM-0007WU-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 17, 2001 at 06:27:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
> > Intel (year 2001) mentions that the behaviour of REP is undefined when it
> > is not used with string opcodes. BTW, according to the same manual, REP is
> > supposed to modify ecx, but it looks like is is not the case here... which
> > is fortunate, since ecx is never saved. :-)
> 
> rep nop is a pentium IV operation. Its retroactively after testing defined
> to be portable and ok. 

Are we sure that the value of ECX doesn't matter on a 386?  Or does it
count down doing nops ECX times on a 386?

-- Jamie
