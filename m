Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSLXPet>; Tue, 24 Dec 2002 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLXPet>; Tue, 24 Dec 2002 10:34:49 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:44110 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S264686AbSLXPes>;
	Tue, 24 Dec 2002 10:34:48 -0500
Date: Tue, 24 Dec 2002 16:42:35 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] Cannot open root device
Message-ID: <20021224154235.GA318@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20021224131957.GA549@dreamland.darkstar.lan> <3E087A37.DDF392D0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E087A37.DDF392D0@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Dec 24, 2002 at 07:16:07AM -0800, Andrew Morton ha scritto: 
> > VFS: Cannot open root device "305" or 03:05
> 
> Does this fix t?
> 
> 
> --- 25/init/do_mounts.c~devfs-fix	Tue Dec 24 07:15:16 2002
> +++ 25-akpm/init/do_mounts.c	Tue Dec 24 07:15:21 2002
> @@ -848,11 +848,6 @@ void prepare_namespace(void)
>  {
>  	int is_floppy;
>  
> -#ifdef CONFIG_DEVFS_FS
> -	sys_mount("devfs", "/dev", "devfs", 0, NULL);
> -	do_devfs = 1;
> -#endif
> -
>  	md_run_setup();
>  
>  	if (saved_root_name[0]) {

Yes, now I  can mount my root  fs. I still have problems  with the other
filesystems, but maybe this is related to modules...

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.
