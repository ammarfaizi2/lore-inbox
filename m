Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933014AbWFWK5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbWFWK5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932999AbWFWK5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:57:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26242 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S933020AbWFWK4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:56:35 -0400
Date: Thu, 22 Jun 2006 22:38:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] cpufreq: fix powernow-k8 load bug
Message-ID: <20060622203855.GD2959@openzaurus.ucw.cz>
References: <4498DA08.1010309@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4498DA08.1010309@oracle.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix powernow-k8 doesn't load bug.
> Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/35145
> 
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=dce0ca36f2ae348f005735e9acd400d2c0954421
> 
> 
> 
> ---
>  arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2617-pv.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> +++ linux-2617-pv/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> @@ -1008,7 +1008,7 @@ static int __cpuinit powernowk8_cpu_init
>  		 * an UP version, and is deprecated by AMD.
>  		 */
>  
> -		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
> +		if ((num_online_cpus() != 1)) {
>  			printk(KERN_ERR PFX "MP systems not supported by PSB BIOS structure\n");
>  			kfree(data);
>  			return -ENODEV;
> 

Seems wrong to me... what if I boot, then hotplug second cpu?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

