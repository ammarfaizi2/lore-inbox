Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWHRVOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWHRVOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWHRVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:14:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45832 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964934AbWHRVOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:14:16 -0400
Date: Fri, 18 Aug 2006 23:14:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 1/7] UBC: kconfig
Message-ID: <20060818211415.GB7813@stusta.de>
References: <44E33893.6020700@sw.ru> <44E33B46.2010200@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33B46.2010200@sw.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:35:34PM +0400, Kirill Korotaev wrote:
> Add kernel/ub/Kconfig file with UBC options and
> includes it into arch Kconfigs
> 
> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> 
> ---
> arch/i386/Kconfig    |    2 ++
> arch/ia64/Kconfig    |    2 ++
> arch/powerpc/Kconfig |    2 ++
> arch/ppc/Kconfig     |    2 ++
> arch/sparc/Kconfig   |    2 ++
> arch/sparc64/Kconfig |    2 ++
> arch/x86_64/Kconfig  |    2 ++
> kernel/ub/Kconfig    |   25 +++++++++++++++++++++++++
> 8 files changed, 39 insertions(+)
>...
> --- ./arch/powerpc/Kconfig.arkcfg	2006-08-07 14:07:12.000000000 +0400
> +++ ./arch/powerpc/Kconfig	2006-08-10 17:55:58.000000000 +0400
> @@ -1038,6 +1038,8 @@ source "arch/powerpc/platforms/iseries/K
> 
> source "lib/Kconfig"
> 
> +source "ub/Kconfig"

kernel/ub/Kconfig

>...
> --- ./arch/ppc/Kconfig.arkcfg	2006-07-10 12:39:10.000000000 +0400
> +++ ./arch/ppc/Kconfig	2006-08-10 17:56:13.000000000 +0400
> @@ -1414,6 +1414,8 @@ endmenu
> 
> source "lib/Kconfig"
> 
> +source "ub/Kconfig"

kernel/ub/Kconfig

>...
> --- ./arch/sparc/Kconfig.arkcfg	2006-04-21 11:59:32.000000000 +0400
> +++ ./arch/sparc/Kconfig	2006-08-10 17:56:24.000000000 +0400
> @@ -296,3 +296,5 @@ source "security/Kconfig"
> source "crypto/Kconfig"
> 
> source "lib/Kconfig"
> +
> +source "ub/Kconfig"

kernel/ub/Kconfig

> --- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
> +++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
> @@ -432,3 +432,5 @@ source "security/Kconfig"
> source "crypto/Kconfig"
> 
> source "lib/Kconfig"
> +
> +source "lib/Kconfig"

kernel/ub/Kconfig

>...
> --- ./kernel/ub/Kconfig.ubkm	2006-07-28 13:07:38.000000000 +0400
> +++ ./kernel/ub/Kconfig	2006-07-28 13:09:51.000000000 +0400
> @@ -0,0 +1,25 @@
> +#
> +# User resources part (UBC)
> +#
> +# Copyright (C) 2006 OpenVZ. SWsoft Inc
> +
> +menu "User resources"
> +
> +config USER_RESOURCE
> +	bool "Enable user resource accounting"
> +	default y
>...

Optional functionality shouldn't default to y.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

