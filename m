Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272506AbTHEQLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272525AbTHEQLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:11:24 -0400
Received: from poup.poupinou.org ([195.101.94.96]:64773 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S272506AbTHEQLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:11:23 -0400
Date: Tue, 5 Aug 2003 18:11:17 +0200
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805161117.GA1511@poupinou.org>
References: <20030805072631.GC5876@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805072631.GC5876@louise.pinerecords.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 09:26:31AM +0200, Tomas Szepe wrote:
> Resend: patch against test2-bk4.
> Sanitize power management config menus, take two.
> 
> -- 
> Tomas Szepe <szepe@pinerecords.com>
> 
> 

I don't understand this chunk:

> diff -urN a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
> --- a/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-10 23:30:33.000000000 +0200
> +++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-27 13:50:30.000000000 +0200
> @@ -2,10 +2,9 @@
>  # CPU Frequency scaling
>  #
>  
> -menu "CPU Frequency scaling"
> -
>  config CPU_FREQ
>  	bool "CPU Frequency scaling"
> +	depends on PM
>  	help
>  	  Clock scaling allows you to change the clock speed of CPUs on the
>  	  fly. This is a nice method to save battery power on notebooks,
> @@ -16,6 +15,8 @@
>  
>  	  If in doubt, say N.
>  
> +if CPU_FREQ
> +
>  source "drivers/cpufreq/Kconfig"
>  
>  config CPU_FREQ_TABLE
> @@ -162,4 +163,4 @@
>  
>  	  If in doubt, say N.
>  
> -endmenu
> +endif

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
