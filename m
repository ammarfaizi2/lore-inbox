Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUFALp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUFALp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUFALp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:45:29 -0400
Received: from pD952C7EB.dip.t-dialin.net ([217.82.199.235]:717 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264991AbUFALpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:45:25 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: Re: 2.6.7-rc2-mm1
Date: Tue, 1 Jun 2004 13:39:56 +0200
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Andy Lutomirski <luto@myrealbox.com>
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011159.23532@zodiac.zodiac.dnsalias.org> <20040601202839.01c8a220.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <20040601202839.01c8a220.akiyama.nobuyuk@jp.fujitsu.com>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011339.58286@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. Juni 2004 13:28 schrieb AKIYAMA Nobuyuki:
> > config attached, plain 2.6.7-rc2-mm1, only with dsdt patch for my laptop.
>
> Please try the patch below.

Did not work for me, but the other one mentioned by Andy looks good

> diff -Nur linux-2.6.7-rc2-mm1.org/kernel/sysctl.c
> linux-2.6.7-rc2-mm1/kernel/sysctl.c ---
> linux-2.6.7-rc2-mm1.org/kernel/sysctl.c	2004-06-01 19:47:22.000000000 +0900
> +++ linux-2.6.7-rc2-mm1/kernel/sysctl.c	2004-06-01 20:21:13.000000000 +0900
> @@ -63,7 +63,7 @@
>  extern int printk_ratelimit_jiffies;
>  extern int printk_ratelimit_burst;
>
> -#if defined(__i386__)
> +#ifdef CONFIG_X86
>  extern int unknown_nmi_panic;
>  extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
>  				  void __user *, size_t *);
> @@ -624,7 +624,7 @@
>  		.mode		= 0444,
>  		.proc_handler	= &proc_dointvec,
>  	},
> -#if defined(__i386__)
> +#ifdef CONFIG_X86
>  	{
>  		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
>  		.procname       = "unknown_nmi_panic",

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291



