Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSEGWEO>; Tue, 7 May 2002 18:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEGWEN>; Tue, 7 May 2002 18:04:13 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:41461 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314277AbSEGWEL>; Tue, 7 May 2002 18:04:11 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 7 May 2002 16:02:35 -0600
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Possible SCSI (sr) mini-cleanup
Message-ID: <20020507220235.GB27824@turbolinux.com>
Mail-Followup-To: Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205071445480.4189-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 07, 2002  14:50 -0600, Thunder from the hill wrote:
> I don't see where the variable and the label have been used. Are they 
> useful for anything? If they are, tell me please!

> @@ -723,8 +721,6 @@
>  		goto cleanup_cds;
>  	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
>  	return 0;
> -cleanup_sizes:
> -	kfree(sr_sizes);
>  cleanup_cds:
>  	kfree(scsi_CDs);
>  cleanup_devfs:

Note that you are also removing the "kfree(sr_sizes)" which is
definitely used...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

