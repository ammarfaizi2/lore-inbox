Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUKFV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUKFV3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUKFV3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:29:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1042 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261477AbUKFV3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:29:51 -0500
Date: Sat, 6 Nov 2004 22:29:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Len Brown <len.brown@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041106212917.GP1295@stusta.de>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418CEE3A.40503@conectiva.com.br>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 01:31:06PM -0200, Arnaldo Carvalho de Melo wrote:
> 
> Suggestion that satisfies both of you, I think:
> 
> #undef ACPI_FUTURE_USAGE
> #ifdef ACPI_FUTURE_USAGE
> tons of unused exported functions
> #endif /* ACPU_FUTURE_USAGE */
> 
> This is what is being done in at least one case in the kernel network
> subsystem, incremental patches adds new functions, to be used by
> future patches, but sometimes Real Life (tm) gets in the way and the
> programmer stalls development for some time, no problem, just ifdef it.
> 
> When, in the future, some functions start being used, hey, very easy
> to remove the #ifdef.
> 
> Even for people trying to debug such subsystems eventually to get
> something working its _nice_ to know at first glance what is really
> being used, speeding up the process for the benefit or everybody.

That's a good idea.

To make it easier, I could send a patc to move all the ACPI 
EXPORT_SYMBOL's away from acpi_ksyms.c or you have to touch two files 
for every function.

@Len:
What's your opinion on this proposal?

> Best Regards,
> 
> - Arnaldo
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

