Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUKLUpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUKLUpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUKLUpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 15:45:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64427 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261903AbUKLUo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 15:44:58 -0500
Message-ID: <41952022.1050607@pobox.com>
Date: Fri, 12 Nov 2004 15:42:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tharbaugh@lnxi.com
CC: linux-kernel@vger.kernel.org, klibc@zytor.com, akpm@digeo.com,
       azarah@nosferatu.za.org
Subject: Re: [PATCH] gen_init_cpio-slink_pipe_sock
References: <1100290509.3171.8.camel@tubarao>
In-Reply-To: <1100290509.3171.8.camel@tubarao>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thayne Harbaugh wrote:
> diff -ur linux-2.6.10-rc1.orig/drivers/block/Kconfig linux-2.6.10-rc1/drivers/block/Kconfig
> --- linux-2.6.10-rc1.orig/drivers/block/Kconfig	2004-11-12 11:03:52.657108248 -0700
> +++ linux-2.6.10-rc1/drivers/block/Kconfig	2004-11-12 11:07:28.458301480 -0700
> @@ -363,10 +363,14 @@
>  	    file <name> <location> <mode> <uid> <gid>
>  	    dir <name> <mode> <uid> <gid>
>  	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
> +	    slink <name> <target> <mode> <uid> <gid>
> +	    pipe <name> <mode> <uid> <gid>
> +	    sock <name> <mode> <uid> <gid>
>  
>  	  Where:
> -	    <name>      name of the file/dir/nod in the archive
> +	    <name>      name of the file/dir/nod/etc in the archive
>  	    <location>  location of the file in the current filesystem
> +	    <target>    link target
>  	    <mode>      mode/permissions of the file
>  	    <uid>       user id (0=root)
>  	    <gid>       group id (0=root)

This info should get moved out of Kconfig, and into a Documentation/* 
text file somewhere.



> +/*
> + * Original work by Jeff Garzick

Please spell my last name correctly :)
