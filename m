Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263493AbRFFFip>; Wed, 6 Jun 2001 01:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbRFFFif>; Wed, 6 Jun 2001 01:38:35 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:38404 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263488AbRFFFiR>; Wed, 6 Jun 2001 01:38:17 -0400
Date: Wed, 6 Jun 2001 09:37:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010606093700.A1445@jurassic.park.msu.ru>
In-Reply-To: <20010605214107.A566@jurassic.park.msu.ru> <Pine.GSO.3.96.1010605201147.26115F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010605201147.26115F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jun 05, 2001 at 08:32:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 08:32:50PM +0200, Maciej W. Rozycki wrote:
> ((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)
> 
> to support 32-bit binaries.  So if the personality is set appropriately
> for netscape, mmap() should work fine as is, placing maps in the low 4GB.

This works perfectly with ELF, but unfortunately netscape isn't recognized
as 32 bit binary.

> No need to patch arch_get_unmapped_area(), but OSF/1 compatibility code
> might need fixing.  I suppose an OSF/1 binary must have an appropriate
> flag set in its header after building with the -taso option so that the
> system knows the binary wants 32-bit addressing.

I'm not sure if COFF headers have such flag at all. I'll check this.

Ivan.
