Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbWHWXSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWHWXSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWHWXSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:18:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51210 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965298AbWHWXSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:18:25 -0400
Date: Thu, 24 Aug 2006 01:18:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060823231823.GG19810@stusta.de>
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608230806.k7N8654c000504@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:06:05AM -0700, Stephane Eranian wrote:
>...
> --- linux-2.6.17.9.base/arch/i386/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.9/arch/i386/perfmon/Kconfig	2006-08-21 03:37:46.000000000 -0700
> @@ -0,0 +1,55 @@
> +menu "Hardware Performance Monitoring support"
> +config PERFMON
> +  	bool "Perfmon2 performance monitoring interface"
> +	select X86_LOCAL_APIC
> +	default y
>...

- if you select something, you must ensure the dependencies of what you 
  are select'ing are fulfilled (e.g. !X86_VOYAGER)
- optional features shouldn't default to y

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

