Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272088AbRH2X3r>; Wed, 29 Aug 2001 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272109AbRH2X3h>; Wed, 29 Aug 2001 19:29:37 -0400
Received: from u-236-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.236]:13965
	"EHLO dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S272089AbRH2X3Z>; Wed, 29 Aug 2001 19:29:25 -0400
Date: Thu, 30 Aug 2001 01:26:04 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, Harald Barth <haba@pdc.kth.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Size of pointers in sys_call_table?
Message-ID: <20010830012604.A17417@dea.linux-mips.net>
In-Reply-To: <3B8B9C00.4842710D@didntduck.org> <E15blYK-0006Fb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15blYK-0006Fb-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 28, 2001 at 05:17:24PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 05:17:24PM +0100, Alan Cox wrote:

> > The layout of the sys_call_table is totally architecture dependant.  The
> > question to ask here is why do you need to use it?  Modifying it to hook
> > into syscalls is frowned upon.
> 
> And potentially unsafe (think about caching, and non atomic writes on
> some platforms)

Breakage practically guaranteed on MIPS systems where additional information
beyond the pointer is associated with a syscall entry point.  Breakage also
guaranteed on ccNUMA systems that run per-node copies of the kernel.

  Ralf
