Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWEaObh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWEaObh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWEaObh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:31:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33480 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965043AbWEaObg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:31:36 -0400
Date: Wed, 31 May 2006 16:21:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/11] 2.6.17-rc5 perfmon2 patch for review: modified i386
 files
In-Reply-To: <200605311352.k4VDqV88028437@frankl.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0605311620150.17704@scrub.home>
References: <200605311352.k4VDqV88028437@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 May 2006, Stephane Eranian wrote:

> diff -ur linux-2.6.17-rc5.orig/arch/i386/Kconfig linux-2.6.17-rc5/arch/i386/Kconfig
> --- linux-2.6.17-rc5.orig/arch/i386/Kconfig	2006-05-30 05:31:59.000000000 -0700
> +++ linux-2.6.17-rc5/arch/i386/Kconfig	2006-05-30 02:48:12.000000000 -0700
> @@ -763,6 +763,21 @@
>  	  /sys/devices/system/cpu.
>  
>  
> +menu "Hardware Performance Monitoring support"
> +
> +config PERFMON
> +  	bool "Perfmon2 performance monitoring interface"
> +	select X86_LOCAL_APIC
> +	default y

Drop the defaults and I'm pretty sure you don't want to use select.


> +  	help
> +  	  include the perfmon2 performance monitoring interface
> + 	  in the kernel. See <http://www.hpl.hp.com/research/linux/perfmon> for
> + 	  more details. If you're unsure, say Y.
> + 
> +source "arch/i386/perfmon/Kconfig"
> +endmenu

The whole menu can be moved there.

bye, Roman
