Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUD1Vrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUD1Vrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUD1Vod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:44:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:46284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbUD1VoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:44:01 -0400
Date: Wed, 28 Apr 2004 14:37:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: make lkconfig quiet
Message-Id: <20040428143713.6a64167d.rddunlap@osdl.org>
In-Reply-To: <20040428205900.GA1678@elf.ucw.cz>
References: <20040428205900.GA1678@elf.ucw.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 22:59:00 +0200 Pavel Machek wrote:

| Ammount of boot messages on my machine is now so big that important
| info (like what went wrong with mouse) scroll away. Oops. This kills
| some offenders. Please apply,
| 								Pavel
| 
| --- clean/kernel/configs.c	2003-09-28 22:06:44.000000000 +0200
| +++ linux/kernel/configs.c	2004-04-28 22:56:49.000000000 +0200
| @@ -77,8 +77,10 @@
|  {
|  	struct proc_dir_entry *entry;
|  
| +#ifdef MODULE
|  	printk(KERN_INFO "ikconfig %s with /proc/config*\n",
|  	       IKCONFIG_VERSION);
| +#endif
|  
|  	/* create the current config file */
|  	entry = create_proc_entry("config.gz", S_IFREG | S_IRUGO,


Where do you see MODULE in this config option?

config IKCONFIG
        bool "Kernel .config support"


Killing 1-liners is a slow way to accomplish what you want, IMO.
Go after the big ones.  :)

--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
