Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314124AbSEDPiK>; Sat, 4 May 2002 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSEDPiJ>; Sat, 4 May 2002 11:38:09 -0400
Received: from ASYNC7-9.NET.CS.CMU.EDU ([128.2.188.71]:18948 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S314124AbSEDPiI>; Sat, 4 May 2002 11:38:08 -0400
Date: Sat, 4 May 2002 09:41:18 -0400
To: Ward Fenton <ward@db2adm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8 syntax errors in fs/ufs/super.c
Message-ID: <20020504134118.GA17203@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: Ward Fenton <ward@db2adm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205032310200.21194-100000@roz.db2adm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 11:15:10PM -0400, Ward Fenton wrote:
> The following is a portion of the 2.4.19-pre8 patch with a correction
> for a few syntax errors.
> 
> from patch-2.4.19-pre8
> missing commas in several added printk statements...

That's not just the only problem,

> +	if (uspi->s_bsize < 512) {
> +		printk("ufs_read_super: fragment size %u is too small\n"
> +			uspi->s_fsize);
> +		goto failed;
> +	}
> +	if (uspi->s_bsize > 4096) {
> +		printk("ufs_read_super: fragment size %u is too large\n"
> +			uspi->s_fsize);
> +		goto failed;
> +	}

The patch is testing s_bsize and complains about s_fsize.

Jan

