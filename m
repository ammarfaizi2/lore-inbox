Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314870AbSEGWjI>; Tue, 7 May 2002 18:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEGWjI>; Tue, 7 May 2002 18:39:08 -0400
Received: from pD952A78A.dip.t-dialin.net ([217.82.167.138]:58018 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314870AbSEGWjH>; Tue, 7 May 2002 18:39:07 -0400
Date: Tue, 7 May 2002 16:39:01 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andreas Dilger <adilger@clusterfs.com>
cc: Thunder from the hill <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Possible SCSI (sr) mini-cleanup
In-Reply-To: <20020507220235.GB27824@turbolinux.com>
Message-ID: <Pine.LNX.4.44.0205071637410.15559-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Andreas Dilger wrote:
> >  	return 0;
> > -cleanup_sizes:
> > -	kfree(sr_sizes);
> 
> Note that you are also removing the "kfree(sr_sizes)" which is
> definitely used...

Definitely not. If it's better to kfree(sr_sizes), we should move that 
_before_ the return.

							       Regards,
								Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

