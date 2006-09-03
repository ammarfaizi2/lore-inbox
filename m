Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWICXd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWICXd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 19:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWICXd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 19:33:28 -0400
Received: from ozlabs.org ([203.10.76.45]:38785 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932156AbWICXd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 19:33:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
Date: Mon, 4 Sep 2006 09:33:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
References: <200609040050.13410.alon.barlev@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev writes:

> Current implementation stores a static command-line
> buffer allocated to COMMAND_LINE_SIZE size. Most
> architectures stores two copies of this buffer, one
> for future reference and one for parameter parsing.

Under what circumstances do we actually need a command line of more
than 256 bytes?

It seems to me that if 256 bytes isn't enough, we should take a deep
breath, step back, and think about whether there might be a better way
to pass whatever information it is that's using up so much of the
command line.

Paul.

-- 
VGER BF report: H 0
