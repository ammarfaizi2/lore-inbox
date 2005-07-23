Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVGWXsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVGWXsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVGWXsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 19:48:16 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:25325 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262067AbVGWXsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 19:48:15 -0400
Date: Sat, 23 Jul 2005 16:48:02 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: torvalds@osdl.org, rlrevell@joe-job.com, cw@f00f.org, akpm@osdl.org,
       len.brown@intel.com, dtor_core@ameritech.net, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050723164802.70b51b8a.rdunlap@xenotime.net>
In-Reply-To: <42D731A4.40504@gmail.com>
References: <42D3E852.5060704@mvista.com>
	<42D540C2.9060201@tmr.com>
	<Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	<20050713184227.GB2072@ucw.cz>
	<Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	<1121282025.4435.70.camel@mindpipe>
	<d120d50005071312322b5d4bff@mail.gmail.com>
	<1121286258.4435.98.camel@mindpipe>
	<20050713134857.354e697c.akpm@osdl.org>
	<20050713211650.GA12127@taniwha.stupidest.org>
	<9a874849050714170465c979c3@mail.gmail.com>
	<1121386505.4535.98.camel@mindpipe>
	<Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	<42D731A4.40504@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005 05:46:44 +0200 Jesper Juhl wrote:

> +static int __init jiffies_increment_setup(char *str)
> +{
> +	printk(KERN_NOTICE "setting up jiffies_increment : ");
> +	if (str) {
> +		printk("kernel_hz = %s, ", str);
> +	} else {
> +		printk("kernel_hz is unset, ");
> +	}
> +	if (!strncmp("100", str, 3)) {

BTW, if someone enters "kernel_hz=1000", this check (above) for "100"
matches (detects) 100, not 1000.

> +		jiffies_increment = 10;
> +		printk("jiffies_increment set to 10, effective HZ will be 100\n");
> +	} else if (!strncmp("250", str, 3)) {
> +		jiffies_increment = 4;
> +		printk("jiffies_increment set to 4, effective HZ will be 250\n");
> +	} else {
> +		jiffies_increment = 1;
> +		printk("jiffies_increment set to 1, effective HZ will be 1000\n");
> +	}
> +
> +	return 1;
> +}

---
~Randy
