Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSJZNSG>; Sat, 26 Oct 2002 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261382AbSJZNSF>; Sat, 26 Oct 2002 09:18:05 -0400
Received: from codepoet.org ([166.70.99.138]:49840 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S261372AbSJZNSF>;
	Sat, 26 Oct 2002 09:18:05 -0400
Date: Sat, 26 Oct 2002 07:24:19 -0600
From: Erik Andersen <andersen@codepoet.org>
To: bert hubert <ahu@ds9a.nl>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de-cryptify ide-disk host protected area output
Message-ID: <20021026132419.GA11930@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	bert hubert <ahu@ds9a.nl>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
References: <20021026130701.GA29860@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021026130701.GA29860@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Oct 26, 2002 at 03:07:01PM +0200, bert hubert wrote:
> Useless number '1' being printed leading to operator confusion.
> 
> --- linux-2.5.44/drivers/ide/ide-disk.c~orig	Sat Oct 26 14:59:35 2002
> +++ linux-2.5.44/drivers/ide/ide-disk.c	Sat Oct 26 15:00:40 2002
> @@ -1128,7 +1128,7 @@
>  {
>  	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
>  	if (flag)
> -		printk("%s: host protected area => %d\n", drive->name, flag);
> +		printk("%s: supports host protected area", drive->name);
>  	return flag;
>  }

Even better -- kill the prink entirely.  If anyone really
cares, they can run 'hdparm -I <drivename>' and get the
exhaustive list of everything the drive supports....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
