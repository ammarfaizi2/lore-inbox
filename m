Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756004AbWKQWqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbWKQWqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756005AbWKQWqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:46:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.200.83]:64470 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1756004AbWKQWqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:46:35 -0500
From: alex1000@comcast.net
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling 2.6.19rc[56]
Date: Fri, 17 Nov 2006 22:46:33 +0000
Message-Id: <111720062246.3570.455E3BC90004E5C700000DF22207021053CFCFCFCE980A040E@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Oct  4 2006)
X-Authenticated-Sender: YWxleDEwMDBAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mattia Dongili <malattia@linux.it>
> On Fri, Nov 17, 2006 at 06:10:01PM +0000, alex1000@comcast.net wrote:
> > I get the following error when attempting to compile 2.6.19rc[56]
> > 
> > drivers/built-in.o(.text+0x7ef32): In function `powersave_bias_target':
> > : undefined reference to `cpufreq_frequency_table_target'
> > drivers/built-in.o(.text+0x7ef7d): In function `powersave_bias_target':
> > : undefined reference to `cpufreq_frequency_table_target'
> > drivers/built-in.o(.text+0x7efb3): In function `powersave_bias_target':
> > : undefined reference to `cpufreq_frequency_table_target'
> > drivers/built-in.o(.text+0x7f056): In function `ondemand_powersave_bias_init':
> > : undefined reference to `cpufreq_frequency_get_table'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> I just sent this to the CPUFreq mailing list.
> 
> Allow CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2cc71b6..491779a 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -107,6 +107,7 @@ config CPU_FREQ_GOV_USERSPACE
>  
>  config CPU_FREQ_GOV_ONDEMAND
>  	tristate "'ondemand' cpufreq policy governor"
> +	select CPU_FREQ_TABLE
>  	help
>  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
>  	  The governor does a periodic polling and 

Problem solved.

Thanks
