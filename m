Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288947AbSANJjx>; Mon, 14 Jan 2002 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289059AbSANJjn>; Mon, 14 Jan 2002 04:39:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288944AbSANJjY>; Mon, 14 Jan 2002 04:39:24 -0500
Subject: Re: [PATCH] 2.5: PATH_MAX length fix
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 14 Jan 2002 09:50:54 +0000 (GMT)
Cc: torvalds@transmeta.com, cyeoh@samba.org, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
In-Reply-To: <E16PyvQ-0006zk-00@wagner.rustcorp.com.au> from "Rusty Russell" at Jan 14, 2002 03:40:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q3lW-0001Cv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ working-2.4.14-pathmax/scripts/mkdep.c	Wed Nov 21 12:01:44 2001
> @@ -218,7 +218,7 @@
>  void add_path(const char * name)
>  {
>  	struct path_struct *path;
> -	char resolved_path[PATH_MAX+1];
> +	char resolved_path[PATH_MAX];
>  	const char *name2;

This is a user mode application running on an unknown host. Its most 
definitely correct and only safe before the change

