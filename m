Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVDMBOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVDMBOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVDMBLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:11:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48656 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263055AbVDMBGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:06:31 -0400
Date: Wed, 13 Apr 2005 03:06:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: 2.6.12-rc2-mm3 (ACPI build problem)
Message-ID: <20050413010626.GJ3631@stusta.de>
References: <425C0AFE.9080106@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C0AFE.9080106@aknet.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 09:53:02PM +0400, Stas Sergeev wrote:
> Hello.
> 
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> Fails to compile with
> !CONFIG_ACPI && CONFIG_SMP.
> CONFIG_SMP sets CONFIG_X86_HT,
> which sets CONFIG_ACPI_BOOT,
> but that fails without CONFIG_ACPI:
> 
>  CC      arch/i386/kernel/setup.o
> arch/i386/kernel/setup.c:96: error: syntax error before ???acpi_sci_flags???
> arch/i386/kernel/setup.c:96: warning: type defaults to ???int??? in 
> declaration of ???acpi_sci_flags???
> arch/i386/kernel/setup.c:96: warning: data definition has no type or 
> storage class
> arch/i386/kernel/setup.c: In function ???parse_cmdline_early???:
> arch/i386/kernel/setup.c:811: error: request for member ???trigger??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:814: error: request for member ???trigger??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:817: error: request for member ???polarity??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:820: error: request for member ???polarity??? in 
> something not a structure or union

Known bug.

Workaround:
Enable CONFIG_ACPI.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

