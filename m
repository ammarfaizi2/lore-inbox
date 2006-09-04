Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWIDIcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWIDIcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIDIcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:32:15 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:59116 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750890AbWIDIcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:32:13 -0400
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Paul Mackerras <paulus@samba.org>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <1157338220.10336.147.camel@nigel.suspend2.net>
References: <200609040050.13410.alon.barlev@gmail.com>
	 <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
	 <1157338220.10336.147.camel@nigel.suspend2.net>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 04 Sep 2006 10:32:07 +0200
Message-Id: <1157358727.5078.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 12:50 +1000, Nigel Cunningham wrote:
> I agree. The current limit varies widely, most often being 256 or 512,
> but sometimes also 896 (s390!) or 1024 (arm, arm26, parisc) or 4096
> (uml). Would users and developers of those arches care to enlighten? Why
> 896?

Simple. Between 0x10480 and 0x10800 there are 0x380 bytes available.
That makes 895 characters for the commandline. Completly obvious, how
could you miss it ? ;-)
The reason is our initial address space layout for the very first kernel
images. Now it is hard to changed because the different ipl tools rely
on the layout. We choose to add a few more bytes than 256 because on
s390 we potentially have many devices. The dasd= parameter can really be
big.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



-- 
VGER BF report: H 0
