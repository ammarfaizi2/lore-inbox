Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSEEAWc>; Sat, 4 May 2002 20:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSEEAWb>; Sat, 4 May 2002 20:22:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1275
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315779AbSEEAWb>; Sat, 4 May 2002 20:22:31 -0400
Date: Sat, 4 May 2002 17:22:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
Message-ID: <20020505002212.GA2392@matchmail.com>
Mail-Followup-To: Neil Conway <nconway_kernel@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020504121520.52836.qmail@web21510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 01:15:20PM +0100, Neil Conway wrote:
> -	byte stat;
> +	byte stat,unit;

[snip]

>  #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
> -	byte unit = (drive->select.b.unit & 0x01);
> +	unit = (drive->select.b.unit & 0x01);

Why are you moving the init of "unit" out of that ifdef?

Can you see if this problem is still in 2.5 also?
