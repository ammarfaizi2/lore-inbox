Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWIDCuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWIDCuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 22:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWIDCuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 22:50:32 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10664 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751323AbWIDCub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 22:50:31 -0400
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
References: <200609040050.13410.alon.barlev@gmail.com>
	 <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 12:50:20 +1000
Message-Id: <1157338220.10336.147.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-09-04 at 09:33 +1000, Paul Mackerras wrote:
> Alon Bar-Lev writes:
> 
> > Current implementation stores a static command-line
> > buffer allocated to COMMAND_LINE_SIZE size. Most
> > architectures stores two copies of this buffer, one
> > for future reference and one for parameter parsing.
> 
> Under what circumstances do we actually need a command line of more
> than 256 bytes?
> 
> It seems to me that if 256 bytes isn't enough, we should take a deep
> breath, step back, and think about whether there might be a better way
> to pass whatever information it is that's using up so much of the
> command line.

I agree. The current limit varies widely, most often being 256 or 512,
but sometimes also 896 (s390!) or 1024 (arm, arm26, parisc) or 4096
(uml). Would users and developers of those arches care to enlighten? Why
896?

Regards,

Nigel


-- 
VGER BF report: H 4.24346e-05
