Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWICWK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWICWK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWICWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:10:20 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:25236 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750959AbWICWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:10:05 -0400
Date: Sun, 3 Sep 2006 16:10:02 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, grundler@parisc-linux.org, geert@linux-m68k.org,
       zippel@linux-m68k.org, paulus@samba.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: Re: [PATCH 01/26] Dynamic kernel command-line - common
Message-ID: <20060903221002.GE2558@parisc-linux.org>
References: <200609040050.13410.alon.barlev@gmail.com> <200609040052.15870.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609040052.15870.alon.barlev@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:52:14AM +0300, Alon Bar-Lev wrote:
> @@ -116,8 +116,12 @@ extern void time_init(void);
>  void (*late_time_init)(void);
>  extern void softirq_init(void);
>  
> -/* Untouched command line (eg. for /proc) saved by 
> arch-specific code. */
> -char saved_command_line[COMMAND_LINE_SIZE];
> +/* Untouched command line saved by arch-specific code. */
> +char __initdata boot_command_line[COMMAND_LINE_SIZE];

Your patch is wordwrapped.

Also, what was the point of all this?  Was there some discussion that
this would be useful?

-- 
VGER BF report: H 0.0043987
