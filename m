Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314625AbSEDQ1K>; Sat, 4 May 2002 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314643AbSEDQ1J>; Sat, 4 May 2002 12:27:09 -0400
Received: from imladris.infradead.org ([194.205.184.45]:29448 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314625AbSEDQ1I>; Sat, 4 May 2002 12:27:08 -0400
Date: Sat, 4 May 2002 17:26:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.13-dj2
Message-ID: <20020504172656.A22693@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020504114119.GA17853@suse.de> <Pine.NEB.4.44.0205041809410.283-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 06:16:29PM +0200, Adrian Bunk wrote:
> The first part of the error message is strange. 2.5.13-dj2 does exactly
> the following change to this file:
> 
> 
> --- linux-2.5.13/drivers/scsi/cpqfcTSinit.c	Fri May  3 01:22:40 2002
> +++ linux-2.5/drivers/scsi/cpqfcTSinit.c	Fri May  3 12:28:12 2002
> @@ -532,7 +532,7 @@
> 
>  	// must be super user to send stuff directly to the
>  	// controller and/or physical drives...
> -	if( !capable(CAP_SYS_ADMIN) )
> +	if( !capable(CAP_RAW_IO) )
>  	  return -EPERM;

This should be CAP_SYS_RAWIO
