Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUI3UoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUI3UoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUI3UoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:44:19 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51652 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269416AbUI3UjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:39:18 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: minor IDE clean up I noticed
Date: Thu, 30 Sep 2004 20:05:36 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040930175430.GA688@devserv.devel.redhat.com>
In-Reply-To: <20040930175430.GA688@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409302005.36089.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fixed 4 days ago in ide-dev-2.6 :)

On Thursday 30 September 2004 19:54, Alan Cox wrote:
> Nowdays a drive always has a driver
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c linux-2.6.9rc3/drivers/ide/ide-proc.c
> --- linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 15:35:48.169975152 +0100
> +++ linux-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 16:33:46.423200288 +0100
> @@ -365,20 +365,7 @@
>  	{
>  		unsigned short *val = (unsigned short *) page;
>  		
> -		/*
> -		 *	The current code can't handle a driverless
> -		 *	identify query taskfile. Now the right fix is
> -		 *	to add a 'default' driver but that is a bit
> -		 *	more work. 
> -		 *
> -		 *	FIXME: this has to be fixed for hotswap devices
> -		 */
> -		 
> -		if(DRIVER(drive))
> -			err = taskfile_lib_get_identify(drive, page);
> -		else	/* This relies on the ID changes */
> -			val = (unsigned short *)drive->id;
> -
> +		err = taskfile_lib_get_identify(drive, page);
>  		if(!err)
>  		{						
>  			char *out = ((char *)page) + (SECTOR_WORDS * 4);
